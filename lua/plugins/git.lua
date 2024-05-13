return {
	{ -- Adds git related signs to the gutter, as well as utilities for managing changes
		"lewis6991/gitsigns.nvim",
		opts = {
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
			preview_config = {
				border = "rounded",
				style = "minimal",
			},
			current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
			current_line_blame_opts = {
				virt_text = true,
				virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
				delay = 8000,
				ignore_whitespace = true,
				-- virt_text_priority = 100,
			},
			current_line_blame_formatter = "<author> | <author_time> | <summary>",
			current_line_blame_formatter_opts = {
				relative_time = true,
			},
		},

		config = function(plugin)
			require("gitsigns").setup(plugin.opts)

			vim.keymap.set("n", "<leader>gb", ":Gitsigns blame_line<CR>")
			vim.keymap.set("n", "<leader>gB", ":Gitsigns toggle_current_line_blame<CR>")

			vim.api.nvim_set_hl(0, "GitSignsCurrentLineBlame", { fg = "#353535" })

			vim.api.nvim_set_hl(0, "GitSignsAdd", { fg = "#343C32", bg = "NONE" })
			vim.api.nvim_set_hl(0, "GitSignsChange", { fg = "#2D3838", bg = "NONE" })
			vim.api.nvim_set_hl(0, "GitSignsDelete", { fg = "#422C2A", bg = "NONE" })

		end,
	},
}
