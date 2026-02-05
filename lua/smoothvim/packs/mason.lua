vim.pack.add({
  { src = "https://github.com/williamboman/mason.nvim" },
  { src = "https://github.com/williamboman/mason-lspconfig.nvim" },
  { src = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim" },
  { src = "https://github.com/neovim/nvim-lspconfig" },
})

require("mason").setup()
require("mason-lspconfig").setup()

require("mason-tool-installer").setup({
  ensure_installed = {
    "lua_ls",
    "ts_ls",
    "eslint_d",
    "tailwindcss-language-server",
    "editorconfig-checker",
    "vim-language-server",
    "prettier", -- prettier formatter
    "stylua", -- lua formatter
    "cssls",
    "lua-language-server",
    "editorconfig-checker",
    { "eslint_d", version = "13.1.2" },
  },
})
