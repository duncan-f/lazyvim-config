local config = function()
	local telescope = require("telescope")
	telescope.setup({
		defaults = {
			mappings = {
				i = {
					["<C-j>"] = "move_selection_next",
					["<C-k>"] = "move_selection_previous",
				},
			},
		},
		pickers = {
			find_files = {
				theme = "dropdown",
				previewer = true,
				hidden = true,
			},
			git_files = {
				theme = "dropdown",
				previewer = true,
				hidden = true,
			},
			live_grep = {
				theme = "dropdown",
				previewer = true,
			},
			buffers = {
				theme = "dropdown",
				previewer = true,
			},
		},
	})
end

return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	lazy = false,
	dependencies = { "nvim-lua/plenary.nvim" },
	config = config,
	keys = {
		{ "<leader>fk", "<cmd>Telescope keymaps<CR>", desc = "Show Keymaps" },
		{ "<leader>fh", "<cmd>Telescope help_tags<CR>", desc = "Show Help Tags" },
		{ "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Find Files" },
		{ "<leader>fg", "<cmd>Telescope git_files<CR>", desc = "Git Files" },
		{ "<leader>fG", "<cmd>Telescope live_grep<CR>", desc = "Live Grep" },
		{ "<leader>fb", "<cmd>Telescope buffers<CR>", desc = "Find Buffers" },
	},
}
