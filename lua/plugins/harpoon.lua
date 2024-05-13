return {
	"0xWaleed/harpoon",
	lazy = false,
	opts = {
		global_settings = {
			-- sets the marks upon calling `toggle` on the ui, instead of require `:w`.
			save_on_toggle = false,

			-- saves the harpoon file upon every change. disabling is unrecommended.
			save_on_change = true,

			-- sets harpoon to run the command immediately as it's passed to the terminal when calling `sendCommand`.
			enter_on_sendcmd = false,

			-- closes any tmux windows harpoon that harpoon creates when you close Neovim.
			tmux_autoclose_windows = false,

			-- filetypes that you want to prevent from adding to the harpoon list menu.
			excluded_filetypes = { "harpoon" },

			-- set marks specific to each git branch inside git repository
			mark_branch = false,

			-- enable tabline with harpoon marks
			tabline = false,
			tabline_prefix = "   ",
			tabline_suffix = "   ",
		}
	},
	config = function(plugin)
		local harp = require("harpoon")
		local harpMark = require("harpoon.mark")
		local harpUI = require("harpoon.ui")

		harp.setup(plugin.opts)

		require("telescope").load_extension('harpoon')

		local max_files = 9

		local function clear_keymaps()
			for i = 1, max_files do
				pcall(vim.keymap.del, "n", ("g%s"):format(i))
			end

			-- NOTE: A hackey way to reset whichkey, wrap it with pcall
			-- as which-key is not built-in at is not required
			-- so better to silently ignore
			pcall(function()
				require("which-key").reset()
			end)
		end

		local map = function(fileNumber)
			local marked = harpMark.get_marked_file(fileNumber)
			vim.keymap.set("n", ("g%s"):format(fileNumber), function()
				harpUI.nav_file(fileNumber)
			end, { desc = ("Go \"%s\""):format(marked.filename) })
		end

		local total = 0

		local function update_file_navigate_keymaps()
			local count = harp.get_mark_config().marks

			if total == #count then
				return
			end

			clear_keymaps()

			total = #count
			for i = 1, #count do
				map(i)
			end
		end

		harpMark.on("changed", update_file_navigate_keymaps)

		vim.keymap.set("n", "gA", function()
			harpMark.add_file()
		end, { desc = ("Add file to list") })

		vim.keymap.set("n", "gH", function()
			harpUI.toggle_quick_menu()
		end, { desc = ("Add file to list") })
	end
}
