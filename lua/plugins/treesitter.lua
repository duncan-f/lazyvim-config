local config = function()
	require("nvim-treesitter.configs").setup({
		build = ":TSUpdate",
		indent = {
			enable = true,
		},
		ignore_install = {},
		-- autotag = {
		-- 	enable = true,
		-- },
		event = {
			"BufReadPre",
			"BufNewFile",
		},
		ensure_installed = {
			"rust",
			"json",
			"javascript",
			"typescript",
			"yaml",
			"html",
			"css",
			"markdown",
			"bash",
			"lua",
			"solidity",
			"gitignore",
			"python",
		},
		sync_install = false,
		auto_install = true,
		highlight = {
			enable = true,
			additional_vim_regex_highlighting = false,
		},
		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = "<C-s>",
				node_incremental = "<C-s>",
				scope_incremental = false,
				node_decremental = "<BS>",
			},
		},
	})
end

return {
	"nvim-treesitter/nvim-treesitter",
  branch = 'master',
	lazy = false,
	version = nil,
	config = config,
}
