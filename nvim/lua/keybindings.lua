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
        ["<C-j>"] = "move_selection_next",
        ["<C-k>"] = "move_selection_previous",
        ["<Down>"] = "move_selection_next",
        ["<Up>"] = "move_selection_previous",
        ["<C-n>"] = "cycle_history_next",
        ["<C-p>"] = "cycle_history_prev",
        ["<C-c>"] = "close", -- close window
        ["<C-u>"] = "preview_scrolling_up",
        ["<C-d>"] = "preview_scrolling_down",
    },
}

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf }
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
        vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
        vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
        vim.keymap.set('n', '<space>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, opts)
        vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
        vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', '<space>f', function()
            vim.lsp.buf.format { async = true }
        end, opts)
    end,
})

return pluginkeys
