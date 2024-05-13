local n = 1

if n == 0 then
	-- NOTE: this sometimes breaks for no reason
	return {
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function(_, opts)
			local autopairs = require("nvim-autopairs")
			autopairs.setup(opts)

			local ac = require("nvim-autopairs.completion.cmp")
			local status, cmp = pcall(require, "cmp")
			if not status then
				return
			end
			cmp.event:on("confirm_done", ac.on_confirm_done())
		end
		-- use opts = {} for passing setup options
		-- this is equalent to setup({}) function
	}
end

if n == 1 then
	return {
		"altermo/ultimate-autopair.nvim",
		event = { "InsertEnter", "CmdlineEnter" },
		branch = "v0.6",
		commit = "042587c63b2b2776a83337748d53dba8b67ec545",
		opts = {
			--Config goes here
		},
	}
end
