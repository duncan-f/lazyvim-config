return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		{ "folke/neodev.nvim", opts = {} },
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"hrsh7th/nvim-cmp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-nvim-lsp",
		"creativenull/efmls-configs-nvim",
		{ "antosha417/nvim-lsp-file-operations", config = true },
	},
	config = function()
		require("neoconf").setup({})

		-- import lspconfig plugin
		-- local lspconfig = require("lspconfig")
		local lspconfig_status, lspconfig = pcall(require, "lspconfig")
		if not lspconfig_status then
			return
		end

		-- import cmp-nvim-lsp plugin
		-- local cmp_nvim_lsp = require("cmp_nvim_lsp")
		local cmp_nvim_lsp_status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
		if not cmp_nvim_lsp_status then
			return
		end

		local keymap = vim.keymap -- for conciseness

		local on_attach = function(_, bufnr)
			local opts = { noremap = true, silent = true, buffer = bufnr }

			-- set keybinds
			opts.desc = "Show LSP references"
			keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

			opts.desc = "Show LSP definitions"
			keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

			opts.desc = "Show LSP implementations"
			keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

			opts.desc = "Show LSP type definitions"
			keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

			opts.desc = "Show buffer diagnostics"
			keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

			opts.desc = "Show harpoon marks"
			keymap.set("n", "<leader>m", "<cmd>Telescope harpoon marks<CR>", opts) -- show  diagnostics for file

			opts.desc = "Go to declaration"
			keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

			opts.desc = "See available code actions"
			keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

			opts.desc = "Smart rename"
			keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

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
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

		require("vim.lsp.protocol").CompletionItemKind = {
			"", -- Text
			"0", -- Method
			"0", -- Function
			"", -- Constructor
			"", -- Field
			"", -- Variable
			"", -- Class
			"ﰮ", -- Interface
			"", -- Module
			"", -- Property
			"", -- Unit
			"", -- Value
			"了", -- Enum
			"", -- Keyword
			"﬌", -- Snippet
			"", -- Color
			"", -- File
			"", -- Reference
			"", -- Folder
			"", -- EnumMember
			"", -- Constant
			"", -- Struct
			"", -- Event
			"ﬦ", -- Operator
			"", -- TypeParameter
		}

		vim.diagnostic.config({
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = " ",
					[vim.diagnostic.severity.WARN] = " ",
					[vim.diagnostic.severity.HINT] = "󰠠 ",
					[vim.diagnostic.severity.INFO] = " ",
				},
				texthl = {
					[vim.diagnostic.severity.ERROR] = "Error",
					[vim.diagnostic.severity.WARN] = "Warning",
					[vim.diagnostic.severity.HINT] = "Hint",
					[vim.diagnostic.severity.INFO] = "Info",
				},
				numhl = {
					[vim.diagnostic.severity.ERROR] = "",
					[vim.diagnostic.severity.WARN] = "",
					[vim.diagnostic.severity.HINT] = "",
					[vim.diagnostic.severity.INFO] = "",
				},
			},
		})

		require("neodev").setup({})

		-- configure lua server (with special settings)
		lspconfig["lua_ls"].setup({
			on_attach = on_attach,
			capabilities = capabilities,
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

		-- configure assembly server
		lspconfig["asm_lsp"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
    })

		-- configure html server
		lspconfig["html"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
    })

		-- json
		lspconfig["jsonls"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
    })

		-- configure typescript server with plugin
		lspconfig["ts_ls"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			settings = {
				init_options = { hostInfo = "neovim" },
				cmd = { "typescript-language-server", "--stdio" },
				filetypes = {
					"javascript",
					"javascriptreact",
					"javascript.jsx",
					"typescript",
					"typescriptreact",
					"typescript.tsx",
				},
			},
		})

		-- configure intelephense server for php
		lspconfig["intelephense"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
    })

		-- configure css server
		lspconfig["cssls"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
    })

		-- configure tailwindcss server
		lspconfig["tailwindcss"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
    })

		-- configure astro server
		lspconfig["astro"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
    })

		-- configure graphql language server
		lspconfig["graphql"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
    })

		-- configure emmet language server
		lspconfig["emmet_ls"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
    })

		-- bash
		lspconfig["bashls"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
    })

		-- configure python server
		lspconfig["pylsp"].setup({
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
		lspconfig["clangd"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			cmd = {
				"clangd",
				"--offset-encoding=utf-16",
			},
		})

		-- LaTex
		lspconfig["texlab"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
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
		-- local asmfmt = require("efmls-configs.formatters.asmfmt")
		-- local phpcs = require("efmls-configs.linters.phpcs")
		-- local pint = require("efmls-configs.formatters.pint")

		-- configure efm server
		vim.lsp.config("efm", {
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
				"php",
				"asm",
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
					-- asm = { asmfmt },
					lua = { luacheck, stylua },
					python = { ruff, black },
					javascript = { eslint, prettier_d },
					typescript = { eslint, prettier_d },
					javascriptreact = { eslint, prettier_d },
					typescriptreact = { eslint, prettier_d },
					vue = { eslint, prettier_d },
					svelte = { eslint, prettier_d },
					astro = { eslint, prettier_d },
					markdown = { prettier_d },
					docker = { hadolint, prettier_d },
					json = { eslint, fixjson },
					jsonc = { eslint, fixjson },
					sh = { shellcheck, shfmt },
					solidity = { solhint },
					html = { prettier_d },
					css = { prettier_d },
					c = { clangformat, cpplint },
					cpp = { clangformat, cpplint },
					tex = { vale, latexindent },
					bib = { vale, latexindent },
					-- php = { phpcs, pint },
				},
			},
		})
	end,
}
