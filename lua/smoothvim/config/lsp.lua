local cmp_nvim_lsp = require("cmp_nvim_lsp")
-- used to enable autocompletion (assign to every lsp server config)
local capabilities = cmp_nvim_lsp.default_capabilities()

-- Enable LSP servers for Neovim 0.11+
local lsps = {
  {
    "ts_ls",
    {
      filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact" },
      capabilities = capabilities,
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
      filetypes = { "lua" },
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" },
          },
          completion = {
            callSnippet = "Replace",
          },
          -- Using stylua for formatting.
          format = { enable = false },
          hint = {
            enable = true,
            arrayIndex = "Disable",
          },
          runtime = {
            version = "LuaJIT",
          },
          telemetry = {
            enable = false,
          },
          workspace = {
            checkThirdParty = false,
            library = {
              vim.env.VIMRUNTIME,
              "${3rd}/luv/library",
            },
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
for idx, lsp in pairs(lsps) do
  if type(lsp) == "table" then
    local name, config = lsp[1], lsp[2] or {}
    vim.lsp.enable(name)
    vim.lsp.config(name, config)
  elseif type(lsp) == "string" then
    vim.lsp.enable(lsp)
  else
    print("Error with #" .. idx .. " LSP")
  end
end

-- lsp signature config
require("lsp_signature").setup({
  bind = true,
  handler_opts = {
    border = "rounded",
  },
})
