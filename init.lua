require("smoothvim.config.core")
require("smoothvim.keymaps.core")
require("smoothvim.keymaps.plugins")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    { import = "smoothvim.plugins" },
    { import = "smoothvim.plugins.lsp" },
    { import = "smoothvim.plugins.mason" },
    { import = "smoothvim.plugins.git" },
  },
  defaults = {
    lazy = false,
    version = false,
  },
  install = { colorscheme = { "tokyonight", "habamax" } },
  checker = {
    enabled = true,
    notify = false,
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})

local cmp_nvim_lsp = require("cmp_nvim_lsp")
-- used to enable autocompletion (assign to every lsp server config)
local capabilities = cmp_nvim_lsp.default_capabilities()

-- LSP settings
local lsps = {
  {
    "ts_ls",
    {
      filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact" },
      -- capabilities = capabilities,
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
      -- capabilities = capabilities,
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
    -- {
    --   capabilities = capabilities,
    -- },
  },
  {
    "jsonls",
    {
      -- capabilities = capabilities,
    },
  },
  {
    "cssls",
    {
      -- capabilities = capabilities,
    },
  },
  {
    "emmet_ls",
    {
      -- capabilities = capabilities,
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

-- zaibatsu
-- elflord
-- murphy
-- wildcharm
vim.cmd("colorscheme base16-tokyo-night-terminal-storm")
