local keymap = vim.keymap

local opts = { noremap = true, silent = true }

-- Directory Navigation
keymap.set("n", "<leader>n", vim.cmd.Ex, opts)
-- keymap.set("n", "<leader>m", vim.cmd.NvimTreeFocus, opts)

-- Pane Navigation
keymap.set("n", "<C-h>", "<C-w>h", opts)
keymap.set("n", "<C-l>", "<C-w>l", opts)
keymap.set("n", "<C-k>", "<C-w>k", opts)
keymap.set("n", "<C-j>", "<C-w>j", opts)

-- Buffer Navigation
keymap.set("n", "<leader>bp", "<cmd>bp<CR>", opts)
keymap.set("n", "<leader>bn", "<cmd>bn<CR>", opts)

-- Window Management
keymap.set("n", "<leader>sv", vim.cmd.vsplit, opts)
keymap.set("n", "<leader>sh", vim.cmd.split, opts)
keymap.set("n", "<leader>sm", vim.cmd.MaximizerToggle, opts)

-- Tabs
keymap.set("n", "<leader>nt", vim.cmd.tabnew, opts)
keymap.set("n", "<leader>ct", vim.cmd.tabclose, opts)
keymap.set("n", "<leader>pt", vim.cmd.tabprevious, opts)
keymap.set("n", "<leader>nn", vim.cmd.tabnext, opts)

-- map keys for Copy/Pasting
keymap.set("x", "<leader>p", '"_dP', opts)
keymap.set("n", "<leader>y", '"+y', opts)
keymap.set("v", "<leader>y", '"+y', opts)
keymap.set("n", "<leader>Y", 'gg"+yG', opts)
keymap.set("v", "<leader>d", '"+d', opts)
keymap.set("n", "<leader>v", '"+p', opts)
keymap.set("n", "<leader>a", '<Esc>"_ggVG', opts)

-- Indenting
keymap.set("v", "<", "<gv", opts)
keymap.set("v", ">", ">gv", opts)

-- Comments
vim.api.nvim_set_keymap("n", "<C-_>", "gcc", { noremap = false })
vim.api.nvim_set_keymap("v", "<C-_>", "gcc", { noremap = false })

-- compiler on writing to file
keymap.set("n", "<leader>c", ":w! <bar> !compiler <c-r>%<CR>")

-- run Python files
keymap.set("n", "<leader>t", ":!python %<CR>")

-- Make file exacutable
keymap.set("n", "<leader>x", ":!chmod +x <c-r>%<CR>")

-- Open corresponding .pdf/.html or preview
keymap.set("n", "<leader>pw", ":!opout <c-r>%<CR><CR>")

keymap.set("n", "<leader><leader>", function()
	vim.cmd("so")
end)
