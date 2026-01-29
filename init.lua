require("smoothvim.config.options")
require("smoothvim.config.autocmds")
require("smoothvim.config.keymaps")
require("smoothvim.config.lsp")
require("smoothvim.plugins")

vim.g.mapleader = "\\"
vim.g.maplocalleader = "\\"

vim.pack.add({
  -- theme packages
  { src = "https://github.com/rose-pine/neovim" },
  { src = "https://github.com/folke/tokyonight.nvim" },

  { src = "https://github.com/neovim/nvim-lspconfig" },
  { src = "https://github.com/mason-org/mason.nvim" },
  { src = "https://github.com/mason-org/mason-lspconfig.nvim" },
  { src = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim" },
  { src = "https://github.com/hrsh7th/cmp-nvim-lsp" },
  { src = "https://github.com/antosha417/nvim-lsp-file-operations" },
})

require("mason").setup()
require("mason-lspconfig").setup()
require("mason-tool-installer").setup({
  ensure_installed = {
    "lua_ls",
    "ts_ls",
    "eslint_d",
    "tailwindcss-language-server",
    "prettierd",
  },
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

-- require("rose-pine").setup({
-- 	styles = {
-- 		transparency = true,
-- 	},
-- })

vim.cmd("colorscheme tokyonight-night")
