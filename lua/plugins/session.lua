local plugin = {}
if true then
	local p = {
		"coffebar/neovim-project",
		opts = {
			-- Project directories
			-- Path to store history and sessions
			datapath = vim.fn.stdpath("data"), -- ~/.local/share/nvim/
			-- Load the most recent session on startup if not in the project directory
			last_session_on_startup = false,
			-- Dashboard mode prevent session autoload on startup
			dashboard_mode = true,

			-- Overwrite some of Session Manager options
			session_manager_opts = {
				autosave_ignore_dirs = {
					vim.fn.expand("~"), -- don't create a session for $HOME/
					"/tmp",
				},
				autosave_ignore_filetypes = {
					-- All buffers of these file types will be closed before the session is saved
					"ccc-ui",
					"gitcommit",
					"gitrebase",
					"qf",
					"toggleterm",
				},
			},
			projects = { -- define project roots
				"~/Repos/*",
				"~/Documents/lmtls-game",
				"~/Documents/lmtls-game/*",
				"~/Documents/0xWaleed/videos/*",
				"~/Documents/0xWaleed/*",
				"~/Scratch/*",
				"~/.dotfiles/**/*",
			},
		},
		init = function()
			vim.keymap.set("n", "<leader>ls", ":Telescope neovim-project history<CR>", {
				noremap = true,
				desc = "Open session menu",
			})

			vim.keymap.set("n", "<leader>lS", ":Telescope neovim-project discover<CR>", {
				noremap = true,
				desc = "Open session menu",
			})

			-- enable saving the state of plugins in the session
			vim.opt.sessionoptions:append("globals") -- save global variables that start with an uppercase letter and contain at least one lowercase letter.
		end,
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-telescope/telescope.nvim", tag = "0.1.4" },
			{ "Shatur/neovim-session-manager" },
		},
		lazy = false,
		priority = 100,
	}
	table.insert(plugin, p)
end

if true then
	local p = {
		"folke/persistence.nvim",
		event = "BufReadPre",
		opts = {
			dir = vim.fn.expand(vim.fn.stdpath("state") .. "/sessions/"), -- directory where session files are saved
			options = { "buffers", "curdir", "tabpages", "winsize" },  -- sessionoptions used for saving
			pre_save = nil,                                            -- a function to call before saving the session
			save_empty = false,                                        -- don't save if there are no open file buffers
		},
		init = function()
			-- restore the session for the current directory
			vim.api.nvim_set_keymap("n", "<leader>Pc", [[<cmd>lua require("persistence").load()<cr>]],
				{ desc = "Load current session in current directory" })

			-- restore the last session
			vim.api.nvim_set_keymap("n", "<leader>Pl", [[<cmd>lua require("persistence").load({ last = true })<cr>]],
				{ desc = "Load last session" })

			-- stop Persistence => session won't be saved on exit
			vim.api.nvim_set_keymap("n", "<leader>Pd", [[<cmd>lua require("persistence").stop()<cr>]],
				{ desc = "Persistence stop" })
		end
	}

	table.insert(plugin, p)
end

return plugin
