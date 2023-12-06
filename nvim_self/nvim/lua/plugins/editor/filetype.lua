return {
	"nathom/filetype.nvim",
	lazy = false,
	-- event = "User FileOpened",
	config = function()
		require("filetype").setup({
			overrides = {
				extensions = {
					-- Set the filetype of *.pn files to potion
					pl = "perl",
					list = "list",
				},
				literal = {
					-- Set the filetype of files named "MyBackupFile" to lua
					-- MyBackupFile = "lua",
				},
				complex = {
					-- Set the filetype of any full filename matching the regex to gitconfig
					[".bashrc"] = "bash", -- Included in the plugin
					[".cshrc"] = "csh",
					[".cshrc.user"] = "csh",
					[".tmux.conf"] = "tmux",
					["tmux.conf"] = "tmux",
				},
			},
		})
	end,
}
