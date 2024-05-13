-- INFO: This plugin highlight the unique charachter in the line
-- to make horizontal movement easier

return {
	"unblevable/quick-scope",
	init = function()
		-- [[
		-- highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline
		-- highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline
		-- ]]
		vim.api.nvim_set_hl(0, "QuickScopePrimary", { fg = "#fabd2f", bold = true })
		vim.api.nvim_set_hl(0, "QuickScopeSecondary", { fg = "#fabd2f", standout = false })
	end,
}
