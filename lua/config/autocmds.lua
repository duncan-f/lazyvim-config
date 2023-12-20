-- auto-format on save
local lsp_fmt_group = vim.api.nvim_create_augroup("LspFormattingGroup", {})
vim.api.nvim_create_autocmd("BufWritePre", {
	group = lsp_fmt_group,
	callback = function()
		local efm = vim.lsp.get_active_clients({ name = "efm" })

		if vim.tbl_isempty(efm) then
			return
		end

		vim.lsp.buf.format({ name = "efm", async = true })
	end,
})

-- Clear tex files builds
vim.api.nvim_create_autocmd({ "VimLeave" }, { pattern = "*.tex", command = "!texclear %" })

-- Ensure of filetype when a new/read file is opened
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, { pattern = "*.tex", command = "set filetype=tex" })

-- source config files when saving
vim.api.nvim_create_autocmd({ "BufWritePost" }, { pattern = "*bashrc,*zshrc", command = "!source %" })
vim.api.nvim_create_autocmd({ "BufWritePost" }, { pattern = "*Xresources,*Xdefaults", command = "!xrdb %" })
vim.api.nvim_create_autocmd({ "BufWritePost" }, { pattern = "files,directories", command = "!shortcuts" })

-- Delete trailing spaces when saving files
vim.cmd([[ autocmd BufWritePre * %s/\s\+$//e ]])
