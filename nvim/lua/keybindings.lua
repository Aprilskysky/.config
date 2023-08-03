local map = vim.api.nvim_set_keymap
local opt = {noremap = true, silent = true}
vim.g.mapleader = " "
map("n", "<space>", "<nop>", opt)
map("n", "<leader>n", ":set relativenumber!<CR>", opt)
map("n", "<leader><CR>", ":set hlsearch!<CR>", opt)
map("n", "<C-Left>", ":vertical resize -3<CR>", opt)
map("n", "<C-Right>", ":vertical resize +3<CR>", opt)
map("n", "<C-Down>", ":resize +3<CR>", opt)
map("n", "<C-Up>", ":resize -3<CR>", opt)
map("v", "J", ":move '>+1<CR>gv-gv", opt)
map("v", "K", ":move '<-2<CR>gv-gv", opt)
map("n", "n", "nzz", opt)
map("n", "N", "Nzz", opt)
-- https://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/
-- vim.keymap.set("n", "j", [[v:count ? 'j' : 'gj']], { noremap = true, expr = true })
-- vim.keymap.set("n", "k", [[v:count ? 'k' : 'gk']], { noremap = true, expr = true })

local pluginkeys = {}

-- nvim-tree
map("n", "<C-n>", ": NvimTreeToggle<CR>", opt)
pluginkeys.nvimtreelist = {
    -- Show the mappings:  `g?`
}
-- bufferline
map("n", "<leader>,", ":BufferLineCyclePrev<CR>", opt)
map("n", "<leader>.", ":BufferLineCycleNext<CR>", opt)
map("n", "<C-w>qq", ":Bdelete!<CR>", opt)
-- Telescope
map("n", "<leader>ff", ":Telescope find_files<CR>", opt)
map("n", "<leader>fg", ":Telescope live_grep<CR>" , opt)
map("n", "<leader>fb", ":Telescope buffers<CR>"   , opt)
map("n", "<leader>fh", ":Telescope help_tags<CR>" , opt)
map("n", "<leader>fo", ":Telescope oldfiles<CR>" , opt)
pluginkeys.telescopelist = {
    i = {
        -- ["<C-n>"] = "move_selection_next",
        -- ["<C-p>"] = "move_selection_previous",
        -- ["<C-c>"] = "close", -- close window
        -- ["<C-u>"] = "preview_scrolling_up",
        -- ["<C-d>"] = "preview_scrolling_down",
    },
}

pluginkeys.on_attach = function(_, bufnr)
    local keymap = function(key, cmd, desc)
        if desc then
            desc = "LSP:"..desc
        end
        vim.keymap.set("n", key, cmd, {buffer = bufnr, desc = desc})
    end
    keymap("gD", vim.lsp.buf.declaration, "goto declaration")
    keymap("gd", require("telescope.builtin").lsp_definitions, "goto definition")
    keymap("gi", require("telescope.builtin").lsp_implementations, "goto implementation")
    keymap("gr", require("telescope.builtin").lsp_references, "goto references")
    keymap("K", "<cmd>Lspsaga hover_doc<CR>", "Hover Documentation")
    keymap("<space>rn", "<cmd>Lspsaga rename ++project<cr>", "rename")
    keymap("<leader>ca", "<cmd>Lspsaga code_action<CR>", "code action")
    keymap("<leader>da", require("telescope.builtin").diagnostics, "diagnostics")
end

return pluginkeys
