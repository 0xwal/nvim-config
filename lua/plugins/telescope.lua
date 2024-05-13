return { -- Fuzzy Finder (files, lsp, etc)
	"nvim-telescope/telescope.nvim",
	event = "VimEnter",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"nvim-telescope/telescope-live-grep-args.nvim",
			-- This will not install any breaking changes.
			-- For major updates, this must be adjusted manually.
			version = "^1.0.0",
			config = function()
				require("telescope").load_extension("live_grep_args")
			end,
		},
		{ -- If encountering errors, see telescope-fzf-native README for installation instructions
			"nvim-telescope/telescope-fzf-native.nvim",

			-- `build` is used to run some command when the plugin is installed/updated.
			-- This is only run then, not every time Neovim starts up.
			build = "make",

			-- `cond` is a condition used to determine whether this plugin should be
			-- installed and loaded.
			cond = function()
				return vim.fn.executable("make") == 1
			end,
		},
		{ "nvim-telescope/telescope-ui-select.nvim" },

		-- Useful for getting pretty icons, but requires a Nerd Font.
		{ "nvim-tree/nvim-web-devicons",            enabled = vim.g.have_nerd_font },
	},
	config = function()
		local previewers = require('telescope.previewers')
		local previewers_utils = require('telescope.previewers.utils')

		local max_size = 100000
		local truncate_large_files = function(filepath, bufnr, opts)
			opts = opts or {}

			filepath = vim.fn.expand(filepath)
			vim.loop.fs_stat(filepath, function(_, stat)
				if not stat then return end
				if stat.size > max_size then
					local cmd = { "head", "-c", max_size, filepath }
					previewers_utils.job_maker(cmd, bufnr, opts)
				else
					previewers.buffer_previewer_maker(filepath, bufnr, opts)
				end
			end)
		end

		require("telescope").setup({
			extensions = {
				["ui-select"] = {
					require("telescope.themes").get_dropdown(),
				},
				["fzf"] = {
					fuzzy = true,              -- false will only do exact matching
					override_generic_sorter = true, -- override the generic sorter
					override_file_sorter = true, -- override the file sorter
					case_mode = "smart_case",  -- or "ignore_case" or "respect_case"
					-- the default case_mode is "smart_case"
				},
			},
			pickers = {
				buffers = {
					mappings = {
						i = {
							["<c-d>"] = "delete_buffer",
						},
					},
				},
			},
			defaults = require("telescope.themes").get_ivy({
				layout_config = {
					height = 10
				},
				file_ignore_patterns = {
					".env"
				},
				buffer_previewer_maker = truncate_large_files
			}),
		})

		-- Enable Telescope extensions if they are installed without erroring
		pcall(require("telescope").load_extension, "fzf")
		pcall(require("telescope").load_extension, "ui-select")

		-- See `:help telescope.builtin`
		local builtin = require("telescope.builtin")
		-- Related to files
		vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "[f]ind [f]iles" })
		vim.api.nvim_set_keymap('n', '<Leader>fF', ':lua require"telescope.builtin".find_files({ hidden = true })<CR>',
			{ noremap = true, silent = true })
		vim.keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "[f]ind [r]ecent Files" })
		vim.keymap.set("n", "<leader>fb", function()
			builtin.buffers({
				ignore_current_buffer = true,
				only_cwd = true,


			})
		end, { desc = "[f]ind [b]uffers" })
		vim.keymap.set(
			"n",
			"<leader>ft",
			require("telescope").extensions.live_grep_args.live_grep_args,
			{ desc = "[f]ind [t]ext" }
		)
		vim.keymap.set("n", "<leader>fm", builtin.marks, { desc = "[f]ind [m]arks" })
		vim.keymap.set("n", "<leader>fD", builtin.diagnostics, { desc = "[f]ind [D]iagnostics" })
		vim.keymap.set("n", "<leader>fs", builtin.lsp_workspace_symbols, { desc = "[f]ind [S]ymbols" })
		vim.keymap.set("n", "<leader>F", builtin.resume, { desc = "Telescope Resume" })

		-- Related to buffer
		vim.keymap.set("n", "<leader>bs", builtin.lsp_document_symbols, { desc = "Buffer symbols" })

		-- vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "[S]earch [H]elp" })
		-- vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
		-- vim.keymap.set("n", "<leader>fs", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
		-- vim.keymap.set("n", "<leader>fw", builtin.grep_string, { desc = "[S]earch current [W]ord" })

		-- It's also possible to pass additional configuration options.
		--  See `:help telescope.builtin.live_grep()` for information about particular keys
		vim.keymap.set("n", "<leader>f/", function()
			builtin.live_grep({
				grep_open_files = true,
				prompt_title = "Live Grep in Open Files",
			})
		end, { desc = "[F]ind [/] in Open Files" })

		local color = "#292929"

		vim.api.nvim_set_hl(0, "TelescopeNormal", { fg = "#3e3e3e" })
		vim.api.nvim_set_hl(0, "TelescopePromptBorder", { fg = color })
		vim.api.nvim_set_hl(0, "TelescopePreviewBorder", { fg = color })
		vim.api.nvim_set_hl(0, "TelescopeResultsBorder", { fg = color })
		-- Shortcut for searching your Neovim configuration files
		-- vim.keymap.set("n", "<leader>sn", function()
		-- 	builtin.find_files({ cwd = vim.fn.stdpath("config") })
		-- end, { desc = "[S]earch [N]eovim files" })
	end,
}
