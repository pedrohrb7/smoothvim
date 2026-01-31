require("mason").setup()
require("mason-lspconfig").setup()
require("mason-tool-installer").setup({
  ensure_installed = {
    "lua_ls",
    "ts_ls",
    "eslint_d",
    "tailwindcss-language-server",
    "prettierd",
    "editorconfig-checker",
    "vim-language-server",
    "stylua",
  },
})
