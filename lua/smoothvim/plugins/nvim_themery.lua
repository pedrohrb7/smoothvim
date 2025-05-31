return {
  "zaldih/themery.nvim",
  lazy = false,
  config = function()
    require("themery").setup({
      themes = {
        "zitchdog-grape",
        "nord",
        "tokyonight-night",
        "tokyonight-storm",
        "tokyonight-day",
        "tokyonight-moon",
        "kanagawa-wave",
        "kanagawa-dragon",
        "darkrose",
      },
    })
  end,
}
