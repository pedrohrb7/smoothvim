vim.g.mapleader = "\\"
vim.g.maplocalleader = "\\"

vim.pack.add({
  "https://www.github.com/echasnovski/mini.nvim",
  -- ============================================================================
  -- theme packages
  { src = "https://github.com/rose-pine/neovim" },
  { src = "https://github.com/folke/tokyonight.nvim" },
  { src = "https://github.com/brenoprata10/nvim-highlight-colors" },
  -- ============================================================================
  {
    src = "https://github.com/JavaHello/spring-boot.nvim",
    version = "218c0c26c14d99feca778e4d13f5ec3e8b1b60f0",
  },
  { src = "https://github.com/mfussenegger/nvim-dap" },
  { src = "https://github.com/nvim-java/nvim-java" },
  { src = "https://github.com/sphamba/smear-cursor.nvim" },

  -- ============================================================================
  -- Dependencies for some plugins
  -- ============================================================================
  { src = "https://github.com/nvim-tree/nvim-web-devicons" },
  { src = "https://github.com/nvim-lua/plenary.nvim" },
})

require("smoothvim.config")
require("smoothvim.packs")

require("mini.notify").setup({
  window = {
    config = {
      anchor = "SE",
      col = vim.o.columns,
      row = vim.o.lines - 2,
    },
  },
})
require("mini.icons").setup({})
require("mini.pairs").setup({})
require("mini.comment").setup({})
require("mini.surround").setup({})
require("nvim-highlight-colors").setup({})
require("java").setup()

-- ============================================================================
-- PLUGIN CONFIGS
-- ============================================================================

require("smear_cursor").setup({
  never_draw_over_target = true,
  smear_insert_mode = false,
  cursor_color = "#FF48B0",
})

require("tokyonight").setup({
  transparent = true,
  styles = {
    -- Background styles. Can be "dark", "transparent" or "normal"
    sidebars = "transparent",
    floats = "dark",
  },
  lualine_bold = true,
})

require("rose-pine").setup({
  styles = {
    transparency = false,
  },
})

vim.cmd.colorscheme("tokyonight")
