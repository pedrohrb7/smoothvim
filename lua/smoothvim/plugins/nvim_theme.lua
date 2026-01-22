return {
  { "RRethy/base16-nvim" },
  {
    "zaldih/themery.nvim",
    lazy = false,
    config = function()
      -- Get all available colorschemes
      local colorschemes = vim.fn.getcompletion("", "color")

      require("themery").setup({
        themes = colorschemes,
        livePreview = true,
      })
    end,
  },
}
