return {
	{
    "ellisonleao/gruvbox.nvim", 
    -- priority = 1000,
    init = function()
      require("gruvbox").setup({
        undercurl = false,
        underline = false,
        bold = false,
        italic = {
          strings = false,
          comments = true,
          operators = false,
          folds = true,
        },
        strikethrough = false,
        invert_selection = false,
        invert_signs = false,
        invert_tabline = false,
        invert_intend_guides = false,
        inverse = false, -- invert background for search, diffs, statuslines and errors
        contrast = "soft", -- can be "hard", "soft" or empty string
        palette_overrides = {},
        overrides = {},
        dim_inactive = false,
        transparent_mode = true,
      })
      vim.o.background="dark" -- system default
      vim.cmd("colorscheme gruvbox")
    end
  }
}
