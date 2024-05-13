if false then
	return {}
end
return {
	"stevearc/conform.nvim",
	config = function()
		local conform = require("conform")
		conform.formatters_by_ft.lua = { "stylua" }
		conform.setup()
	end,
}
