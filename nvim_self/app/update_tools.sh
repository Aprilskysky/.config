#!/usr/bin/env bash
# update_tools.sh - download the latest releases of nvim and developer tools.
#
# Layout:
#   app/nvim-linux-x86_64.appimage   latest stable nvim (glibc 2.17 build)
#   app/package/<tool>/              extracted downloads, one dir per tool
#   app/bin/<binary>                 symlinks to the binaries in package/
#
# Every run checks the latest release of each tool and only re-downloads
# when a newer version is available. Run with `-f` to force re-downloading.
set -euo pipefail

APP_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PKG_DIR="$APP_DIR/package"
BIN_DIR="$APP_DIR/bin"
TMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TMP_DIR"' EXIT

mkdir -p "$PKG_DIR" "$BIN_DIR"

CURL=(curl -fsSL --retry 3 --retry-delay 2)

# latest release tag of a GitHub repo, via the /releases/latest redirect
# (no API rate limits involved)
latest_tag() {
  local repo="$1"
  "${CURL[@]}" -o /dev/null -w '%{url_effective}' "https://github.com/$repo/releases/latest" \
    | sed 's#.*/tag/##'
}

# asset filenames of a release, via the expanded_assets page. the href
# matching is repo-agnostic so renames like mrtazz/checkmake -> checkmake/checkmake
# keep working
list_assets() {
  local repo="$1" tag="$2"
  "${CURL[@]}" "https://github.com/$repo/releases/expanded_assets/$tag" \
    | grep -oE 'href="/[^"]*/releases/download/[^"]+"' \
    | sed "s#.*/download/[^/]*/##; s/\"$//"
}

# ---------------------------------------------------------------------------
# tool registry: add new tools here (repo, asset name pattern, binaries to link)
# ---------------------------------------------------------------------------
tool_repo() {
  case "$1" in
    nvim)         echo "neovim/neovim-releases" ;;
    fzf)          echo "junegunn/fzf" ;;
    rg)           echo "BurntSushi/ripgrep" ;;
    ctags)        echo "universal-ctags/ctags-nightly-build" ;;
    checkmake)    echo "checkmake/checkmake" ;;
    lua_ls)       echo "LuaLS/lua-language-server" ;;
    perlnavigator) echo "bscan/PerlNavigator" ;;
    marksman)     echo "artempyanykh/marksman" ;;
  esac
}

tool_asset() {
  case "$1" in
    nvim)         grep -E '^nvim-linux-x86_64\.appimage$' ;;
    fzf)          grep -E 'fzf-.*-linux_amd64\.tar\.gz$' ;;
    rg)           grep -E 'ripgrep-.*-x86_64-unknown-linux-musl\.tar\.gz$' ;;
    ctags)        grep -E '^uctags-.*-linux-x86_64\.release\.tar\.gz$' ;;
    checkmake)    grep -E 'checkmake-.*\.linux\.amd64$' ;;
    lua_ls)       grep -E '^lua-language-server-.*-linux-x64\.tar\.gz$' ;;
    perlnavigator) grep -E '^perlnavigator-linux-x86_64\.zip$' ;;
    marksman)     grep -E '^marksman-linux-x64$' ;;
  esac
}

# binary basenames to symlink into app/bin (searched inside the archive)
tool_links() {
  case "$1" in
    nvim)         echo "" ;; # the appimage goes to app/ itself
    fzf)          echo "fzf" ;;
    rg)           echo "rg" ;;
    ctags)        echo "ctags readtags" ;;
    checkmake)    echo "checkmake" ;;
    lua_ls)       echo "lua-language-server" ;;
    perlnavigator) echo "perlnavigator" ;;
    marksman)     echo "marksman" ;;
    bash_ls)      echo "bash-language-server" ;;
  esac
}
# ---------------------------------------------------------------------------

# bash-language-server has no GitHub release binaries; install it via npm
# (which also pulls its runtime dependencies). a small wrapper script is
# linked into bin/ so deps resolve regardless of where it is invoked from
install_bash_ls() {
  local force="${1:-}"
  if ! command -v npm >/dev/null 2>&1; then
    echo "[bash_ls] npm is required to install bash-language-server"
    return 1
  fi
  local version
  version="$("${CURL[@]}" https://registry.npmjs.org/bash-language-server/latest \
    | sed -n 's/.*"version":"\([^"]*\)".*/\1/p')"
  if [ -z "$version" ]; then
    echo "[bash_ls] failed to resolve latest version"
    return 1
  fi
  local verfile="$PKG_DIR/.bash_ls.version"
  if [ -z "$force" ] && [ -f "$verfile" ] && [ "$(cat "$verfile")" = "$version" ] \
    && { [ -e "$BIN_DIR/bash-language-server" ] || [ -L "$BIN_DIR/bash-language-server" ]; }; then
    echo "[bash_ls] up to date ($version)"
    return 0
  fi

  local dest="$PKG_DIR/bash_ls"
  rm -rf "$dest"
  mkdir -p "$dest"
  echo "[bash_ls] npm install bash-language-server@$version"
  npm install --prefix "$dest" --no-fund --no-audit "bash-language-server@$version" >/dev/null
  local cli="$dest/node_modules/bash-language-server/out/cli.js"
  if [ ! -f "$cli" ]; then
    echo "[bash_ls] cli.js not found after npm install"
    return 1
  fi

  # wrapper resolves its own location, so the link keeps working when the
  # app dir is synced to a machine with a different $HOME
  cat > "$dest/bash-language-server" <<'EOF'
#!/usr/bin/env bash
self="$(readlink -f "$0")"
dir="$(dirname "$self")"
exec node "$dir/node_modules/bash-language-server/out/cli.js" "$@"
EOF
  chmod +x "$dest/bash-language-server"
  rm -rf "$BIN_DIR/bash-language-server"
  ln -s "$(realpath --relative-to="$BIN_DIR" "$dest/bash-language-server")" \
    "$BIN_DIR/bash-language-server"
  echo "$version" > "$verfile"
  echo "[bash_ls] updated to $version"
}

install_tool() {
  local name="$1" force="${2:-}"
  if [ "$name" = "bash_ls" ]; then
    install_bash_ls "$force"
    return
  fi
  local repo tag
  repo="$(tool_repo "$name")" || {
    echo "[$name] unknown tool, check tool_repo()"
    return 1
  }
  tag="$(latest_tag "$repo")"
  if [ -z "$tag" ]; then
    echo "[$name] failed to resolve latest tag"
    return 1
  fi

  local verfile="$PKG_DIR/.$name.version"
  if [ -z "$force" ] && [ -f "$verfile" ] && [ "$(cat "$verfile")" = "$tag" ]; then
    # self-heal: redo when a managed file went missing (e.g. wiped bin dir)
    local missing="" link
    if [ "$name" = "nvim" ]; then
      [ -x "$APP_DIR/nvim-linux-x86_64.appimage" ] || missing=1
    else
      for link in $(tool_links "$name"); do
        if [ ! -e "$BIN_DIR/$link" ] && [ ! -L "$BIN_DIR/$link" ]; then
          missing=1
        fi
      done
    fi
    if [ -z "$missing" ]; then
      echo "[$name] up to date ($tag)"
      return 0
    fi
  fi

  local asset
  asset="$(list_assets "$repo" "$tag" | tool_asset "$name" | head -1)" || true
  if [ -z "$asset" ]; then
    echo "[$name] no matching asset in release $tag"
    return 1
  fi

  local url="https://github.com/$repo/releases/download/$tag/$asset"
  local file="$TMP_DIR/$asset"
  echo "[$name] downloading $asset"
  "${CURL[@]}" -o "$file" "$url"

  if [ "$name" = "checkmake" ]; then
    echo "[checkmake] WARNING: the official release requires glibc 2.34 and will"
    echo "[checkmake]          not run on glibc 2.17 (CentOS 7). build a static"
    echo "[checkmake]          binary instead:"
    echo "[checkmake]          CGO_ENABLED=0 go build -ldflags '-X main.version=<ver>' ./cmd/checkmake"
  fi

  if [ "$name" = "nvim" ]; then
    # the appimage lives directly in app/
    rm -f "$APP_DIR/$asset"
    cp "$file" "$APP_DIR/$asset"
    chmod +x "$APP_DIR/$asset"
  else
    local dest="$PKG_DIR/$name"
    rm -rf "$dest"
    mkdir -p "$dest"
    case "$asset" in
      *.tar.gz | *.tgz)
        tar -xzf "$file" -C "$dest" ;;
      *.tar.xz)
        tar -xJf "$file" -C "$dest" ;;
      *.zip)
        if command -v unzip >/dev/null 2>&1; then
          unzip -q "$file" -d "$dest"
        elif command -v python3 >/dev/null 2>&1; then
          python3 -m zipfile -e "$file" "$dest"
        else
          echo "[$name] extracting .zip needs unzip or python3"
          return 1
        fi ;;
      *)
        # bare binary: the downloaded file itself is the executable,
        # copy it under the link name so the find loop below picks it up
        local first_link rest
        read -r first_link rest <<< "$(tool_links "$name")"
        cp "$file" "$dest/$first_link" ;;
    esac

    local link
    for link in $(tool_links "$name"); do
      local src
      src="$(find "$dest" -type f -name "$link" | head -1)"
      if [ -z "$src" ]; then
        echo "[$name] binary '$link' not found in archive"
        continue
      fi
      chmod +x "$src"
      rm -rf "$BIN_DIR/$link"
      # relative links keep the whole app dir relocatable (e.g. synced to
      # another machine with a different $HOME)
      local rel
      rel="$(realpath --relative-to="$BIN_DIR" "$src")"
      ln -s "$rel" "$BIN_DIR/$link"
      echo "[$name] linked $link -> $rel"
    done
  fi

  echo "$tag" > "$verfile"
  echo "[$name] updated to $tag"
}

FORCE=""
if [ "${1:-}" = "-f" ]; then
  FORCE=1
fi

TOOLS=(nvim fzf rg ctags checkmake lua_ls perlnavigator marksman bash_ls)
for tool in "${TOOLS[@]}"; do
  install_tool "$tool" "$FORCE" || echo "[$tool] FAILED"
done

echo "done. binaries in $BIN_DIR"
