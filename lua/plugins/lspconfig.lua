return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"windwp/nvim-autopairs",
		"williamboman/mason.nvim",
		"hrsh7th/nvim-cmp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-nvim-lsp",
		"creativenull/efmls-configs-nvim",
		{ "antosha417/nvim-lsp-file-operations", config = true },
	},
	config = function()
		require("neoconf").setup({})

		-- import lspconfig plugin
		local lspconfig = require("lspconfig")

		-- import cmp-nvim-lsp plugin
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		local keymap = vim.keymap -- for conciseness

		local opts = { noremap = true, silent = true }
		local on_attach = function(client, bufnr)
			opts.buffer = bufnr

			-- set keybinds
			opts.desc = "Show LSP references"
			keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

			opts.desc = "Go to declaration"
			keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

			opts.desc = "Show LSP definitions"
			keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

			opts.desc = "Show LSP implementations"
			keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

			opts.desc = "Show LSP type definitions"
			keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

			opts.desc = "See available code actions"
			keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

			opts.desc = "Smart rename"
			keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

			opts.desc = "Show buffer diagnostics"
			keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

			opts.desc = "Show line diagnostics"
			keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

			opts.desc = "Go to previous diagnostic"
			keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

			opts.desc = "Go to next diagnostic"
			keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

			opts.desc = "Show documentation for what is under cursor"
			keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

			opts.desc = "Restart LSP"
			keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
		end

		-- used to enable autocompletion (assign to every lsp server config)
		local capabilities = cmp_nvim_lsp.default_capabilities()

		-- Change the Diagnostic symbols in the sign column (gutter)
		-- (not in youtube nvim video)
		local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

		-- configure lua server (with special settings)
		lspconfig.lua_ls.setup({
			capabilities = capabilities,
			on_attach = on_attach,
			settings = { -- custom settings for lua
				Lua = {
					runtime = {
						-- Tell the language server which version of Lua you're using
						-- (most likely LuaJIT in the case of Neovim)
						version = "LuaJIT",
					},
					-- make the language server recognize "vim" global
					diagnostics = {
						globals = { "vim" },
					},
					workspace = {
						-- make language server aware of runtime files
						library = {
							[vim.fn.expand("$VIMRUNTIME/lua")] = true,
							[vim.fn.stdpath("config") .. "/lua"] = true,
						},
					},
					-- Do not send telemetry data containing a randomized but unique identifier
					telemetry = {
						enable = false,
					},
				},
			},
		})

		-- configure html server
		lspconfig.html.setup({
			capabilities = capabilities,
			on_attach = on_attach,
			filetypes = { "html" },
		})

		-- json
		lspconfig.jsonls.setup({
			capabilities = capabilities,
			on_attach = on_attach,
			filetypes = { "json", "jsonc" },
		})

		-- configure typescript server with plugin
		lspconfig.tsserver.setup({
			capabilities = capabilities,
			on_attach = on_attach,
			filetypes = {
				"typescript",
			},
			root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", ".git"),
		})

		-- configure css server
		lspconfig.cssls.setup({
			capabilities = capabilities,
			on_attach = on_attach,
			filetypes = { "css", "scss", "sass", "less" },
		})

		-- configure tailwindcss server
		lspconfig.tailwindcss.setup({
			capabilities = capabilities,
			on_attach = on_attach,
			filetypes = { "css", "scss", "sass", "less" },
		})

		-- configure astro server
		lspconfig.astro.setup({
			capabilities = capabilities,
			on_attach = on_attach,
			filetypes = { "astro" },
		})

		-- configure graphql language server
		lspconfig.graphql.setup({
			capabilities = capabilities,
			on_attach = on_attach,
			filetypes = {
				"graphql",
				"gql",
				"svelte",
				"typescriptreact",
				"javascriptreact",
			},
		})

		-- configure emmet language server
		lspconfig.emmet_ls.setup({
			capabilities = capabilities,
			on_attach = on_attach,
			filetypes = {
				"html",
				"typescriptreact",
				"javascriptreact",
				"javascript",
				"css",
				"sass",
				"scss",
				"less",
				"svelte",
			},
		})

		-- bash
		lspconfig.bashls.setup({
			capabilities = capabilities,
			on_attach = on_attach,
			filetypes = { "sh", "aliasrc" },
		})

		-- configure python server
		lspconfig.pylsp.setup({
			capabilities = capabilities,
			on_attach = on_attach,
			settings = {
				pylsp = {
					plugins = {
						black = {
							enabled = true,
						},
						isort = {
							enabled = true,
							profile = "black",
						},
					},
				},
			},
		})

		-- C/C++
		lspconfig.clangd.setup({
			capabilities = capabilities,
			on_attach = on_attach,
			cmd = {
				"clangd",
				"--offset-encoding=utf-16",
			},
		})

    -- LaTex
    lspconfig.ltex.setup({
      capabilities = capabilities,
      on_attach = on_attach,
      filetypes = { "tex", "bib" },
    })

		local luacheck = require("efmls-configs.linters.luacheck")
		local stylua = require("efmls-configs.formatters.stylua")
		local ruff = require("efmls-configs.linters.ruff")
		local black = require("efmls-configs.formatters.black")
		local eslint = require("efmls-configs.linters.eslint")
		local prettier_d = require("efmls-configs.formatters.prettier_d")
		local fixjson = require("efmls-configs.formatters.fixjson")
		local shellcheck = require("efmls-configs.linters.shellcheck")
		local shfmt = require("efmls-configs.formatters.shfmt")
		local hadolint = require("efmls-configs.linters.hadolint")
		local solhint = require("efmls-configs.linters.solhint")
		local cpplint = require("efmls-configs.linters.cpplint")
		local clangformat = require("efmls-configs.formatters.clang_format")
		local vale = require("efmls-configs.linters.vale")
		local latexindent = require("efmls-configs.formatters.latexindent")

		-- configure efm server
		lspconfig.efm.setup({
			filetypes = {
				"lua",
				"python",
				"json",
				"jsonc",
				"sh",
				"javascript",
				"javascriptreact",
				"typescript",
				"typescriptreact",
				"svelte",
				"vue",
				"markdown",
				"docker",
				"solidity",
				"html",
				"css",
				"c",
				"cpp",
				"tex",
        "bib",
			},
			init_options = {
				documentFormatting = true,
				documentRangeFormatting = true,
				hover = true,
				documentSymbol = true,
				codeAction = true,
				completion = true,
			},
			settings = {
				languages = {
					lua = { luacheck, stylua },
					python = { ruff, black },
					typescript = { eslint, prettier_d },
					json = { eslint, fixjson },
					jsonc = { eslint, fixjson },
					sh = { shellcheck, shfmt },
					astro = { eslint, prettier_d },
					javascript = { eslint, prettier_d },
					javascriptreact = { eslint, prettier_d },
					typescriptreact = { eslint, prettier_d },
					svelte = { eslint, prettier_d },
					vue = { eslint, prettier_d },
					markdown = { prettier_d },
					docker = { hadolint, prettier_d },
					solidity = { solhint },
					html = { prettier_d },
					css = { prettier_d },
					c = { clangformat, cpplint },
					cpp = { clangformat, cpplint },
					tex = { vale, latexindent },
					bib = { vale, latexindent },
				},
			},
		})
	end,
}
