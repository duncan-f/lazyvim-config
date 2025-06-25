return {
	"thePrimeagen/harpoon",
	lazy = false,
	config = function()
		local mark = require("harpoon.mark")
		local ui = require("harpoon.ui")

		vim.keymap.set("n", "<leader>aa", mark.add_file)
		vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)

		vim.keymap.set("n", "<C-²>", function()
			ui.nav_file(1)
		end)
		vim.keymap.set("n", "<C-$>", function()
			ui.nav_file(2)
		end)
		vim.keymap.set("n", "<C-ù>", function()
			ui.nav_file(3)
		end)
		vim.keymap.set("n", "<C-*>", function()
			ui.nav_file(4)
		end)

		vim.keymap.set("n", "<C-n>", function()
			ui.nav_next()
		end)

		vim.keymap.set("n", "<C-p>", function()
			ui.nav_prev()
		end)
	end,
}
