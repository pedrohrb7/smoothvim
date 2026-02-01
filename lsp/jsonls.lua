local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

---@type vim.lsp.Config
return {
  cmd = { 'vscode-json-language-server', '--stdio' },
  filetypes = { 'json', 'jsonc' },
  capabilities = capabilities,
  init_options = {
    provideFormatter = true,
  },
  root_markers = { '.git' },
}
