vim.g.mapleader = "\\"
vim.g.maplocalleader = "\\"

require("smoothvim.config.packages")

require("smoothvim.config")
require("smoothvim.plugins")

require("tokyonight").setup({
  transparent = true,
  styles = {
    -- Background styles. Can be "dark", "transparent" or "normal"
    sidebars = "transparent",
    floats = "dark",
  },
  lualine_bold = true,
})

-- require("rose-pine").setup({
-- 	styles = {
-- 		transparency = true,
-- 	},
-- })

vim.cmd("colorscheme tokyonight-night")
