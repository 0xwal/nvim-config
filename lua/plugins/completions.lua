-- debounce.lua


return {
	{
		"hrsh7th/cmp-nvim-lsp",
	},
	{
		"L3MON4D3/LuaSnip",
		dependencies = {
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",
		},
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline"
		},
		config = function()
			-- Set up nvim-cmp.
			local cmp = require("cmp")
			local cmpTypes = require("cmp.types")
			require("luasnip.loaders.from_vscode").lazy_load()

			local timer = vim.loop.new_timer()

			local DEBOUNCE_DELAY = 1000

			function debounce()
				timer:stop()
				timer:start(
					DEBOUNCE_DELAY,
					0,
					vim.schedule_wrap(function()
						cmp.complete({ reason = cmp.ContextReason.Auto })
					end)
				)
			end

			-- NOTE: change "plugin.cmp.debounce" to location of debounce.lua
			-- If it's in the lua folder, then change to "debounce"

			-- vim.cmd([[
			-- 	augroup CmpDebounceAuGroup
			-- 		au!
			-- 		au TextChangedI * lua debounce()
			-- 	augroup end
			-- ]])

			-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
			cmp.setup.cmdline(':', {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = 'path' }
				}, {
					{ name = 'cmdline' }
				}),
				matching = { disallow_symbol_nonprefix_matching = false }
			})

			-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
			cmp.setup.cmdline({ '/', '?' }, {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = 'buffer' }
				}
			})


			-- local cmp_autopairs = require("nvim-autopairs.completion.cmp")


			-- cmp.event:on(
			-- 	"confirm_done",
			-- 	cmp_autopairs.on_confirm_done()
			-- )

			cmp.setup({
				enabled = function()
					-- disable completion in comments
					local context = require("cmp.config.context")
					-- keep command mode completion enabled when cursor is in a comment
					if vim.api.nvim_get_mode().mode == "c" then
						return true
					else
						return not context.in_treesitter_capture("comment") and not context.in_syntax_group("Comment")
					end
				end,
				snippet = {
					-- REQUIRED - you must specify a snippet engine
					expand = function(args)
						-- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
						require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
						-- require('snippy').expand_snippet(args.body) -- For `snippy` users.
						-- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
						-- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
					end,
				},
				performance = {
					debounce = 200,
				},

				view = {
					-- entries = { name = "wildmenu", separator = "|" }
				},

				completion = {
					autocomplete = false,
					keyword_length = 1,

					-- this to highlight the first one, issue #209
					completeopt = 'menu,menuone,noinsert'
				},
				window = {
					completion = cmp.config.window.bordered({
						winhighlight = "Normal:Normal,CursorLine:PmenuSel,Search:None"
					}),
					documentation = cmp.config.window.bordered(),

				},
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Insert }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.,
					["<TAB>"] = cmp.mapping.select_next_item({ behavior = cmpTypes.cmp.SelectBehavior.Select }),
					--["<TAB>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "path" },
					-- { name = "vsnip" }, -- For vsnip users.
					{ name = "luasnip" }, -- For luasnip users.
					-- { name = 'ultisnips' }, -- For ultisnips users.
					-- { name = 'snippy' }, -- For snippy users.
				}, { { name = "buffer" } }),

				formatting = {
					fields = { "kind", "abbr", "menu" },
					format = function(entry, vim_item)
						local kind =
								require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
						local strings = vim.split(kind.kind, "%s", { trimempty = true })
						kind.kind = " " .. (strings[1] or "") .. " "
						kind.menu = "    (" .. (strings[2] or "") .. ")"

						return kind
					end,
				},
			})
		end,
	},
}
