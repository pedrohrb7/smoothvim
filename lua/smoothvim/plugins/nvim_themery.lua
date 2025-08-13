return {
  "zaldih/themery.nvim",
  lazy = false,
  config = function()
    require("themery").setup({
      themes = {
        "zitchdog-grape",
        "zitchdog-pine",
        "zitchdog-night",
        "nord",
        "tokyonight-night",
        "tokyonight-storm",
        "tokyonight-day",
        "tokyonight-moon",
        "kanagawa-wave",
        "kanagawa-dragon",
        "vague",
        "darkrose",
      },
    })
  end,
}
