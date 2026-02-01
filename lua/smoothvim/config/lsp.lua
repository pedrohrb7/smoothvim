-- Enable LSP servers for Neovim 0.11+
vim.lsp.enable({
  "ts_ls",
  "eslint",
  "lua_ls",
  "cssls",
  "html",
  "jsonls",
  "yamlls",
})

-- Load Lsp on-demand, e.g: eslint is disable by default
-- e.g: We could enable eslint by set vim.g.lsp_on_demands = {"eslint"}
if vim.g.lsp_on_demands then
  vim.lsp.enable(vim.g.lsp_on_demands)
end
