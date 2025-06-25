return {
	"williamboman/mason-lspconfig.nvim",
	opts = {
		ensure_installed = {
			"efm",
			"bashls",
			"ts_ls",
			"solidity",
			"tailwindcss",
			"lua_ls",
			"emmet_ls",
			"jsonls",
			"clangd",
		},
		automatic_installation = true,
	},
	event = "BufReadPre",
	dependencies = "williamboman/mason.nvim",
}
