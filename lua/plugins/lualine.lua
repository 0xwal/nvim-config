local colors = {
	black        = '#282828',
	-- white        = '#ebdbb2',
	white        = "#343331",
	red          = '#fb4934',
	green        = '#b8bb26',
	blue         = '#83a598',
	yellow       = '#fe8019',
	gray         = '#302F2D',
	darkgray     = '#3c3836',
	lightgray    = '#504945',
	inactivegray = '#7c6f64',
}

local theme = {
	normal = {
		a = { bg = colors.gray, fg = colors.black, gui = 'bold' },
		b = { bg = colors.black, fg = colors.white },
		c = { bg = colors.black, fg = colors.gray },
	},
	insert = {
		a = { bg = colors.lightgray, fg = colors.black, gui = 'bold' },
		b = { bg = colors.black, fg = colors.white },
		c = { bg = colors.black, fg = colors.white },
	},
	visual = {
		a = { bg = colors.blue, fg = colors.black, gui = 'bold' },
		b = { bg = colors.black, fg = colors.white },
		c = { bg = colors.black, fg = colors.black },
	},
	replace = {
		a = { bg = colors.red, fg = colors.black, gui = 'bold' },
		b = { bg = colors.black, fg = colors.white },
		c = { bg = colors.black, fg = colors.white },
	},
	command = {
		a = { bg = colors.green, fg = colors.black, gui = 'bold' },
		b = { bg = colors.black, fg = colors.white },
		c = { bg = colors.black, fg = colors.black },
	},
	inactive = {
		a = { bg = colors.gray, fg = colors.gray, gui = 'bold' },
		b = { bg = colors.black, fg = colors.gray },
		c = { bg = colors.black, fg = colors.gray },
	},
}
return {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},

	opts = {
		options = {
			icons_enabled = true,
			-- theme = custom_gruvbox,
			component_separators = { left = "", right = "" },
			section_separators = { left = "", right = "" },
			disabled_buftypes = {
				-- no clue if this correct
			},
			disabled_filetypes = {
				"toggleterm",

				statusline = {
				},
				winbar = {},
			},
			ignore_focus = {},
			always_divide_middle = true,
			globalstatus = false,
			refresh = {
				statusline = 1000,
				tabline = 1000,
				winbar = 1000,
			},
		},
		sections = {
			lualine_a = { "mode" },
			lualine_b = {
				"branch",
				{
					"filename",

					file_status = true, -- Displays file status (readonly status, modified status)
					newfile_status = false, -- Display new file status (new file means no write after created)
					path = 1,          -- 0: Just the filename
					-- 1: Relative path
					-- 2: Absolute path
					-- 3: Absolute path, with tilde as the home directory
					-- 4: Filename and parent dir, with tilde as the home directory

					shorting_target = 40, -- Shortens path to leave 40 spaces in the window
					-- for other components. (terrible name, any suggestions?)
					symbols = {
						modified = "[+]", -- Text to show when the file is modified.""
						readonly = "[-]", -- Text to show when the file is non-modifiable or readonly.""
						unnamed = "[No Name]", -- Text to show for unnamed buffers.""
						newfile = "[New]", -- Text to show for newly created file before first write""
					},
				},
				"diagnostics",
				"diff",
			},
			lualine_c = {},
			lualine_x = {
				function()
					local ok, pomo = pcall(require, "pomo")
					if not ok then
						return ""
					end

					local timer = pomo.get_first_to_finish()
					if timer == nil then
						return ""
					end

					return "󰄉 " .. tostring(timer)
				end,
				"encoding", "fileformat", "filetype"
			},
			lualine_y = { "progress" },
			lualine_z = { "location" },
		},
		inactive_sections = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = {
				"filename",
			},
			lualine_x = {
				"location"
			},
			lualine_y = {},
			lualine_z = {},
		},
		tabline = {},
		winbar = {},
		inactive_winbar = {},
		extensions = {},
	},
	config = function(plugin)
		local opts = plugin.opts
		-- local custom_gruvbox = require("lualine.themes.gruvbox")

		-- Change the background of lualine_c section for normal mode
		-- custom_gruvbox.normal.b.bg = "#282828"
		-- custom_gruvbox.normal.c.bg = "#282828"
		--
		-- custom_gruvbox.normal.b.fg = "#484848"
		-- custom_gruvbox.normal.c.fg = "#484848"
		--
		-- custom_gruvbox.insert.b.bg = "#282828"
		-- custom_gruvbox.insert.c.bg = "#282828"
		--
		-- custom_gruvbox.command.b.bg = "#282828"
		-- custom_gruvbox.command.c.bg = "#282828"
		--
		--
		-- custom_gruvbox.visual.b.bg = "#282828"
		-- custom_gruvbox.visual.c.bg = "#282828"
		--
		--
		-- custom_gruvbox.insert.b.fg = "#484848"
		-- custom_gruvbox.insert.c.fg = "#484848"
		--
		-- custom_gruvbox.inactive.b.bg = "#282828"
		-- custom_gruvbox.inactive.c.bg = "#282828"
		--
		-- custom_gruvbox.inactive.b.fg = "#484848"
		-- custom_gruvbox.inactive.c.fg = "#484848"

		opts.options.theme = theme

		local lualine = require("lualine")

		vim.keymap.set("n", "<leader>Lh", lualine.hide, { desc = "Hide lualine" })
		vim.keymap.set("n", "<leader>Ls", function() lualine.setup(opts) end, { desc = "Show lualine" })

		-- vim.api.nvim_set_hl(0, "statusline", { bg = "NONE", fg = "#2a2a2a" })
		-- vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "NONE", fg = "#2a2a2a" })

		require("lualine").setup(opts)

		local warning = "#745E2B"
		vim.api.nvim_set_hl(0, "lualine_b_diagnostics_warn_normal", { fg = warning })
		vim.api.nvim_set_hl(0, "lualine_b_diagnostics_warn_command", { fg = warning })
		vim.api.nvim_set_hl(0, "lualine_b_diagnostics_warn_insert", { fg = warning })
		vim.api.nvim_set_hl(0, "lualine_b_diagnostics_warn_visual", { fg = warning })
		vim.api.nvim_set_hl(0, "lualine_b_diagnostics_warn_terminal", { fg = warning })
		vim.api.nvim_set_hl(0, "lualine_b_diagnostics_warn_inactive", { fg = warning })

		local hint = "#44513F"
		vim.api.nvim_set_hl(0, "lualine_b_diagnostics_hint_normal", { fg = hint })
		vim.api.nvim_set_hl(0, "lualine_b_diagnostics_hint_command", { fg = hint })
		vim.api.nvim_set_hl(0, "lualine_b_diagnostics_hint_insert", { fg = hint })
		vim.api.nvim_set_hl(0, "lualine_b_diagnostics_hint_visual", { fg = hint })
		vim.api.nvim_set_hl(0, "lualine_b_diagnostics_hint_terminal", { fg = hint })
		vim.api.nvim_set_hl(0, "lualine_b_diagnostics_hint_inactive", { fg = hint })



		local added = "#343c32"
		local change = "#2d3838"
		local delete = "#422c2a"

		vim.api.nvim_set_hl(0, "lualine_b_diff_added_normal", { fg = added })
		vim.api.nvim_set_hl(0, "lualine_b_diff_added_command", { fg = added })
		vim.api.nvim_set_hl(0, "lualine_b_diff_added_insert", { fg = added })
		vim.api.nvim_set_hl(0, "lualine_b_diff_added_visual", { fg = added })
		vim.api.nvim_set_hl(0, "lualine_b_diff_added_terminal", { fg = added })
		vim.api.nvim_set_hl(0, "lualine_b_diff_added_inactive", { fg = added })


		vim.api.nvim_set_hl(0, "lualine_b_diff_modified_normal", { fg = change })
		vim.api.nvim_set_hl(0, "lualine_b_diff_modified_command", { fg = change })
		vim.api.nvim_set_hl(0, "lualine_b_diff_modified_insert", { fg = change })
		vim.api.nvim_set_hl(0, "lualine_b_diff_modified_visual", { fg = change })
		vim.api.nvim_set_hl(0, "lualine_b_diff_modified_terminal", { fg = change })
		vim.api.nvim_set_hl(0, "lualine_b_diff_modified_inactive", { fg = change })

		vim.api.nvim_set_hl(0, "lualine_b_diff_removed_normal", { fg = delete })
		vim.api.nvim_set_hl(0, "lualine_b_diff_removed_command", { fg = delete })
		vim.api.nvim_set_hl(0, "lualine_b_diff_removed_insert", { fg = delete })
		vim.api.nvim_set_hl(0, "lualine_b_diff_removed_visual", { fg = delete })
		vim.api.nvim_set_hl(0, "lualine_b_diff_removed_terminal", { fg = delete })
		vim.api.nvim_set_hl(0, "lualine_b_diff_removed_inactive", { fg = delete })
	end,
}
