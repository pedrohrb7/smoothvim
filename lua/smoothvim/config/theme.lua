vim.pack.add({
  -- theme packages
  { src = "https://github.com/rose-pine/neovim" },
  { src = "https://github.com/folke/tokyonight.nvim" },
})

require("tokyonight").setup({
  transparent = false,
  styles = {
    -- Background styles. Can be "dark", "transparent" or "normal"
    sidebars = "dark",
    floats = "dark",
  },
  lualine_bold = true,
})

require("rose-pine").setup({
  styles = {
    transparency = true,
  },
})

vim.cmd("colorscheme rose-pine-main")
