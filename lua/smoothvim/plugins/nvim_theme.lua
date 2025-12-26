return {
  { "RRethy/base16-nvim" },
  {
    "zaldih/themery.nvim",
    lazy = false,
    config = function()
      -- Get all available colorschemes
      local colorschemes = vim.fn.getcompletion("", "color")

      local filtered_themes = {}
      for _, theme in ipairs(colorschemes) do
        -- Check for common light theme name patterns
        if not string.match(theme, "light") or not string.match(theme, "day") then
          table.insert(filtered_themes, theme)
        end
      end

      require("themery").setup({
        themes = filtered_themes,
        livePreview = true,
      })
    end,
  },
}
