return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"rust_analyzer",
				},
			})
		end,
	},
	-- {
	-- 	"j-hui/fidget.nvim",
	-- 	opts = {
	-- 		notification = {
	-- 			window = {
	-- 				normal_hl = "Comment", -- Base highlight group in the notification window
	-- 				winblend = 0, -- Background color opacity in the notification window
	-- 				border = "rounded", -- Border around the notification window
	-- 				zindex = 45, -- Stacking priority of the notification window
	-- 				max_width = 0, -- Maximum width of the notification window
	-- 				max_height = 0, -- Maximum height of the notification window
	-- 				x_padding = 1, -- Padding from right edge of window boundary
	-- 				y_padding = 0, -- Padding from bottom edge of window boundary
	-- 				align = "top", -- How to align the notification window
	-- 				relative = "editor", -- What the notification window position is relative to
	-- 			},
	-- 		},
	-- 	},
	-- },
	{ "folke/neodev.nvim", opts = {} },
	{
		"neovim/nvim-lspconfig",
		depenedencies = { "nvim-telescope/telescope.nvim" },
		lazy = false,
		config = function()
			vim.diagnostic.config {
				float = { border = "rounded" },
			}

			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			local lspconfig = require("lspconfig")

			--
			-- local handlers = {
			-- 	["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border, width = 0 }),
			-- 	["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
			-- }
			--

			-- To instead override globally
			-- local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
			-- function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
			-- 	opts = opts or {}
			-- 	-- opts.width = opts.width or 100
			-- 	-- opts.height = opts.height or 100
			-- 	-- opts.border = opts.border or border
			-- 	opts.border = "rounded"
			-- 	return orig_util_open_floating_preview(contents, syntax, opts, ...)
			-- end
			--
			require("neodev").setup({
				-- add any options here, or leave empty to use the default settings
			})


			lspconfig.lua_ls.setup({
				capabilities = capabilities,
				settings = {
					Lua = {
						completion = {
							callSnippet = "Replace",
						},
					},
				},
			})

			lspconfig.rust_analyzer.setup({
				capabilities = capabilities,
			})

			lspconfig.clangd.setup({
				capabilities = capabilities,
			})

			lspconfig.gopls.setup({
				capabilities = capabilities,
			})

			local function organize_imports()
				local params = {
					command = "_typescript.organizeImports",
					arguments = { vim.api.nvim_buf_get_name(0) },
					title = ""
				}
				vim.lsp.buf.execute_command(params)
			end

			lspconfig.tsserver.setup({
				capabilities = capabilities,
				commands = {
					OrganizeImports = {
						organize_imports,
						description = "Organize Imports"
					}
				},
				on_attach = function(client)
					if lspconfig.util.root_pattern("deno.json", "import_map.json")(vim.fn.getcwd()) then
						if client.name == "tsserver" then
							client.stop()
							return
						end
					end
				end
			})

			-- lspconfig.denols.setup({
			-- 	capabilities = capabilities,
			-- })

			lspconfig.phpactor.setup({
				capabilities = capabilities,
			})

			--
			-- lspconfig.ruff_lsp.setup({
			-- 	capabilities = capabilities,
			-- })
			--
			lspconfig.pyright.setup {
				capabilities = capabilities,
				settings = {
					pyright = {
					},
					python = {
						analysis = {
							-- Ignore all files for analysis to exclusively use Ruff for linting
							-- ignore = { "*" },
							typeCheckingMode = "strict"
						},
					},
				},
			}


			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})

			local telescope = require("telescope.builtin")

			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(ev)
					-- Enable completion triggered by <c-x><c-o>
					vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

					-- Buffer local mappings.
					-- See `:help vim.lsp.*` for documentation on any of the below functions
					local opts = { buffer = ev.buf }
					vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
					vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
					vim.keymap.set("n", "gi", telescope.lsp_implementations, opts)
					vim.keymap.set("n", ",", vim.lsp.buf.signature_help, opts)
					vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
					vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)

					vim.keymap.set("n", "<space>wl", function()
						print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
					end, opts)

					vim.keymap.set("n", "<space>D", telescope.lsp_type_definitions, opts)
					vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
					vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)

					vim.keymap.set("n", "gr", telescope.lsp_references, opts)

					vim.keymap.set("n", "<space>bf", function()
						vim.lsp.buf.format({ async = true })
					end, opts)
				end,
			})
		end,
	},
	{
		"onsails/lspkind.nvim",
		config = function()
			require("lspkind").init({
				-- DEPRECATED (use mode instead): enables text annotations
				--
				-- default: true
				-- with_text = true,

				-- defines how annotations are shown
				-- default: symbol
				-- options: 'text', 'text_symbol', 'symbol_text', 'symbol'
				mode = "symbol_text",

				-- default symbol map
				-- can be either 'default' (requires nerd-fonts font) or
				-- 'codicons' for codicon preset (requires vscode-codicons font)
				--
				-- default: 'default'
				preset = "codicons",

				-- override preset symbols
				--
				-- default: {}
				symbol_map = {
					Text = "󰉿",
					Method = "󰆧",
					Function = "󰊕",
					Constructor = "",
					Field = "󰜢",
					Variable = "󰀫",
					Class = "󰠱",
					Interface = "",
					Module = "",
					Property = "󰜢",
					Unit = "󰑭",
					Value = "󰎠",
					Enum = "",
					Keyword = "󰌋",
					Snippet = "",
					Color = "󰏘",
					File = "󰈙",
					Reference = "󰈇",
					Folder = "󰉋",
					EnumMember = "",
					Constant = "󰏿",
					Struct = "󰙅",
					Event = "",
					Operator = "󰆕",
					TypeParameter = "",
				},
			})
		end,
	},
}
