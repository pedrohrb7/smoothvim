return {
  "zaldih/themery.nvim",
  lazy = false,
  config = function()
    require("themery").setup({
      themes = {
        "base16-black-metal-bathory",
        "base16-black-metal-burzum",
        "base16-black-metal-dark-funeral",
        "base16-black-metal-gorgoroth",
        "base16-black-metal-immortal",
        "base16-black-metal-khold",
        "base16-black-metal-marduk",
        "base16-black-metal-mayhem",
        "base16-black-metal-nile",
        "base16-black-metal-venom",
        "base16-black-metal",
        "zitchdog-grape",
        "nord",
        "tokyonight",
        "kanagawa-wave",
        "kanagawa-dragon",
        "darkrose",
      },
    })
  end,
}
