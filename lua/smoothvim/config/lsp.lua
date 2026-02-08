local cmp_nvim_lsp = require("cmp_nvim_lsp")
-- used to enable autocompletion (assign to every lsp server config)
local capabilities = cmp_nvim_lsp.default_capabilities()

-- LSP settings
local lsps = {
  {
    "ts_ls",
    {
      filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact" },
      capabilities = capabilities,
      -- root_dir = lspconfig.util.root_pattern("package.json"),
      single_file_support = false,
      settings = {
        typescript = {
          tsserver = {
            useSyntaxServer = false,
          },
          inlayHints = {
            includeInlayParameterNameHints = "all",
            includeInlayParameterNameHintsWhenArgumentMatchesName = true,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = true,
            includeInlayVariableTypeHintsWhenTypeMatchesName = true,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayEnumMemberValueHints = true,
          },
        },
      },
    },
  },
  {
    "lua_ls",
    {
      capabilities = capabilities,
      settings = {
        Lua = {
          -- make the language server recognize "vim" global
          diagnostics = {
            globals = { "vim" },
          },
          completion = {
            callSnippet = "Replace",
          },
        },
      },
    },
  },
  {
    "dockerls",
    {
      capabilities = capabilities,
    },
  },
  {
    "jsonls",
    {
      capabilities = capabilities,
      filetypes = { "json", "jsonc" },
    },
  },
  {
    "cssls",
    {
      capabilities = capabilities,
    },
  },
  {
    "emmet_ls",
    {
      capabilities = capabilities,
      filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less" },
    },
  },
}

for _, lsp in pairs(lsps) do
  local name, config = lsp[1], lsp[2]

  vim.lsp.enable(name)

  if config then
    vim.lsp.config(name, config)
  end
end
