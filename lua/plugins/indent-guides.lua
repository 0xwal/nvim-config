return {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	opts = {
		scope = {
			show_start = false
		}
	},
	config = function(plugin)
		local opts = plugin.opts
		--
		-- local highlight = {
		-- 	"RainbowRed",
		-- 	"RainbowYellow",
		-- 	"RainbowBlue",
		-- 	"RainbowOrange",
		-- 	"RainbowGreen",
		-- 	"RainbowViolet",
		-- 	"RainbowCyan",
		-- }
		--
		-- local hooks = require "ibl.hooks"
		-- -- create the highlight groups in the highlight setup hook, so they are reset
		-- -- every time the colorscheme changes
		-- hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
		-- 	vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75", blend = 0 })
		-- 	vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B", blend = 0 })
		-- 	vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF", blend = 0 })
		-- 	vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66", blend = 0 })
		-- 	vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379", blend = 0 })
		-- 	vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD", blend = 0 })
		-- 	vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2", blend = 0 })
		-- end)
		--
		-- opts.indent = {
		-- 	highlight = highlight
		-- }
		--

		opts.debounce = 400

		vim.api.nvim_set_hl(0, "IblScope", { fg = "#292929" })
		vim.api.nvim_set_hl(0, "IblIndent", { fg = "#292929" })
		require("ibl").setup(opts)
	end
}
