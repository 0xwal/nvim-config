return {
	"smoka7/multicursors.nvim",
	event = "VeryLazy",
	dependencies = {
		'smoka7/hydra.nvim',
	},
	opts = {},
	cmd = { 'MCstart', 'MCvisual', 'MCclear', 'MCpattern', 'MCvisualPattern', 'MCunderCursor' },
	keys = {
		{
			mode = { 'v', 'n' },
			'<leader>m',
			'<cmd>MCstart<cr>',
			desc = 'Create a selection for selected text or word under the cursor',
		},
	},
	init = function()
		local fg = "#fabd2f"
		local bg = "#504945"

		vim.api.nvim_set_hl(0, "MultiCursorMain", { bg = bg, fg = fg, underline = true })
		vim.api.nvim_set_hl(0, "MultiCursor", { bg = bg, fg = fg, underline = true })
	end
}
