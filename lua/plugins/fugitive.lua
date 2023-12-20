return {
	"tpope/vim-fugitive",
	lazy = false,
	config = function()
		vim.keymap.set("n", "<leader>g", vim.cmd.Git)
	end,
}
