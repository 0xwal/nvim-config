vim.cmd [[

autocmd TermEnter * setlocal nonumber norelativenumber signcolumn=no

autocmd BufLeave term://* stopinsert
autocmd BufEnter,BufWinEnter,WinEnter term://* startinsert



" tmap <ESC><ESC> <C-\><C-n>
" tmap <C-h> <ESC><ESC><C-h>
" tmap <C-l> <ESC><ESC><C-l>
" tmap <C-k> <ESC><ESC><C-k>
" tmap <C-j> <ESC><ESC><C-j>
]]

return {
	"akinsho/toggleterm.nvim",
	version = "*",
	opts = {
		size = 12,
		shade_filetypes = {},
		hide_numbers = true,
		shade_terminals = true,
		insert_mappings = true,
		terminal_mappings = false,
		start_in_insert = true,
		persist_size = true,
		persist_mode = true,
		close_on_exit = true,
		-- open_mapping = "<leader>t",
		direction = "float",
		shell = vim.o.shell,
		autochdir = false,
		auto_scroll = false,
		highlights = {
			-- highlights which map to a highlight group name and a table of it"s values
			-- NOTE: this is only a subset of values, any group placed here will be set for the terminal window split
			Normal = {
				guibg = "#383838",
			},
			NormalFloat = {
				-- link = "282828"
			},
			FloatBorder = {
				guifg = "#383838",
				-- guibg = "#383838",
			},
		},
		winbar = {
			enabled = false,
			name_formatter = function(term) return ("%d:%s"):format(term.id, "term" --[[ , term:_display_name() ]]) end,
		},
		float_opts = {
			winblend = 0,
			title_pos = "left",
			border = "curved"
		},
	},
	init = function()
		vim.keymap.set("n", "<leader>tf", ":ToggleTerm direction=float<CR>", { desc = "Open floating terminal" })
		vim.keymap.set("n", "<leader>t\\", ":ToggleTerm direction=vertical size=60<CR>",
			{ desc = "Open vertical terminal" })
		vim.keymap.set("n", "<leader>t|", ":ToggleTerm direction=vertical size=60<CR>",
			{ desc = "Open vertical terminal" })

		vim.keymap.set("n", "<leader>t-", ":ToggleTerm direction=horizontal<CR>",
			{ desc = "Open horizontal terminal" })

		vim.keymap.set("n", "<leader>tt", ":ToggleTerm<CR>", { desc = "Toggle Terminal" })



		local Terminal = require("toggleterm.terminal").Terminal
		local lazygit  = Terminal:new({
			cmd = "lazygit",
			hidden = true,
			float_opts = {
				width = function()
					local wins = vim.api.nvim_list_wins()
					local width = 0
					for _, w in ipairs(wins) do
						width = width + vim.api.nvim_win_get_width(w)
					end
					return width
				end,
				height = function()
					local wins = vim.api.nvim_list_wins()
					local height = 0
					for _, w in ipairs(wins) do
						height = height + vim.api.nvim_win_get_height(w)
					end
					return height
				end
			}
		})


		---@diagnostic disable-next-line: lowercase-global
		function _lazygit_toggle()
			lazygit:toggle()
		end

		local group = vim.api.nvim_create_augroup("term-navigate-keymaps", {
			clear = true
		})

		vim.api.nvim_create_autocmd("TermOpen", {
			group = group,
			pattern = "term://*",
			callback = function(_ev)
				local opts = { buffer = 0 }
				vim.keymap.set("t", "<C-q>", [[<C-\><C-n>]], opts)
				vim.keymap.set("n", "<esc><esc>", [[:ToggleTerm<CR>]], opts)
				-- vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
				vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
				vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
				vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
				vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)

			end
		})
		-- if you only want these mappings for toggle term use term://*toggleterm#* instead
		-- vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

		vim.api.nvim_set_keymap("n", "<leader>tg", "<cmd>lua _lazygit_toggle()<CR>",
			{ noremap = true, silent = true, desc = "Lazygit" })
	end
}
