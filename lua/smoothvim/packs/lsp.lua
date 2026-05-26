vim.pack.add({
  { src = "https://github.com/williamboman/mason.nvim" },
  { src = "https://github.com/williamboman/mason-lspconfig.nvim" },
  { src = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim" },

  { src = "https://github.com/creativenull/efmls-configs-nvim" },

  { src = "https://github.com/neovim/nvim-lspconfig" },
  { src = "https://github.com/ray-x/lsp_signature.nvim" },
  { src = "https://github.com/antosha417/nvim-lsp-file-operations" },

  { src = "https://github.com/hrsh7th/nvim-cmp" },
  { src = "https://github.com/hrsh7th/cmp-path" },
  { src = "https://github.com/hrsh7th/cmp-buffer" },
  { src = "https://github.com/hrsh7th/cmp-cmdLine" },
  { src = "https://github.com/hrsh7th/cmp-nvim-lsp" },
  { src = "https://github.com/stevearc/conform.nvim" },
  { src = "https://github.com/SergioRibera/cmp-dotenv" },
  { src = "https://github.com/saadparwaiz1/cmp_luasnip" },
  { src = "https://github.com/hrsh7th/cmp-nvim-lsp-signature-help" },

  { src = "https://github.com/L3MON4D3/LuaSnip" },
  { src = "https://github.com/mfussenegger/nvim-lint" },
  { src = "https://github.com/rafamadriz/friendly-snippets" },
})

require("mason").setup({})
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
    { "eslint_d" },
    -- { "eslint_d", version = "13.1.2" },
  },
})
local conform = require("conform")
local util = require("conform.util")
local lint = require("lint")
local cmp = require("cmp")

local augroup = vim.api.nvim_create_augroup("UserLspConfig", { clear = true })

-- ============================================================================
-- LSP, Linting, Formatting & Completion
-- ============================================================================
local diagnostic_signs = {
  Error = " ",
  Warn = " ",
  Hint = "",
  Info = "",
}

vim.diagnostic.config({
  virtual_text = { prefix = "●", spacing = 4 },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = diagnostic_signs.Error,
      [vim.diagnostic.severity.WARN] = diagnostic_signs.Warn,
      [vim.diagnostic.severity.INFO] = diagnostic_signs.Info,
      [vim.diagnostic.severity.HINT] = diagnostic_signs.Hint,
    },
  },
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    border = "rounded",
    source = true,
    header = "",
    prefix = "",
    focusable = false,
    style = "minimal",
  },
})

do
  local orig = vim.lsp.util.open_floating_preview
  ---@diagnostic disable-next-line: duplicate-set-field
  function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
    opts = opts or {}
    opts.border = opts.border or "rounded"
    return orig(contents, syntax, opts, ...)
  end
end

local function lsp_on_attach(ev)
  local client = vim.lsp.get_client_by_id(ev.data.client_id)
  if not client then
    return
  end

  local bufnr = ev.buf
  local opts = { noremap = true, silent = true, buffer = bufnr }

  vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "<leader>gD", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
  vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Show line diagnostics" })
  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  vim.keymap.set("n", "<leader>xx", ":Telescope diagnostics<CR>", opts)

  vim.keymap.set("n", "<leader>gS", function()
    vim.cmd("vsplit")
    vim.lsp.buf.definition()
  end, opts)

  vim.keymap.set("n", "<leader>D", function()
    vim.diagnostic.open_float({ scope = "line" })
  end, opts)

  vim.keymap.set("n", "<leader>ft", function()
    conform.format({
      lsp_fallback = true,
      async = false,
      timeout_ms = 500,
    })
  end, opts)

  -- vim.keymap.set("n", "<leader>nd", function()
  --   vim.diagnostic.jump({ count = 1 })
  -- end, opts)

  -- vim.keymap.set("n", "<leader>pd", function()
  --   vim.diagnostic.jump({ count = -1 })
  -- end, opts)

  -- vim.keymap.set("n", "<leader>fd", function()
  --   require("fzf-lua").lsp_definitions({ jump_to_single_result = true })
  -- end, opts)

  -- vim.keymap.set("n", "<leader>fr", function()
  --   require("fzf-lua").lsp_references()
  -- end, opts)

  -- vim.keymap.set("n", "<leader>ft", function()
  --   require("fzf-lua").lsp_typedefs()
  -- end, opts)

  -- vim.keymap.set("n", "<leader>fs", function()
  --   require("fzf-lua").lsp_document_symbols()
  -- end, opts)

  -- vim.keymap.set("n", "<leader>fw", function()
  --   require("fzf-lua").lsp_workspace_symbols()
  -- end, opts)

  -- vim.keymap.set("n", "<leader>fi", function()
  --   require("fzf-lua").lsp_implementations()
  -- end, opts)
end

vim.api.nvim_create_autocmd("LspAttach", { group = augroup, callback = lsp_on_attach })

local cmp_nvim_lsp = require("cmp_nvim_lsp")
local capabilities = cmp_nvim_lsp.default_capabilities()

vim.lsp.config["*"] = {
  capabilities = capabilities,
}

vim.lsp.config("lua_ls", {
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
})
vim.lsp.enable("jdtls")
vim.lsp.config("dockerls", {})
vim.lsp.config("jsonls", {})
vim.lsp.config("cssls", {})
vim.lsp.config("emmet_ls", {})
vim.lsp.config("pyright", {})
vim.lsp.config("bashls", {})
vim.lsp.config("ts_ls", {
  settings = {
    typescript = {
      tsserver = {
        useSyntaxServer = false,
      },
      inlayHints = {
        includeInlayParameterNameHints = "all",
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = false,
        includeInlayVariableTypeHints = false,
        includeInlayVariableTypeHintsWhenTypeMatchesName = false,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = false,
        includeInlayEnumMemberValueHints = true,
      },
    },
  },
})
vim.lsp.config("gopls", {})
vim.lsp.config("clangd", {})

do
  local luacheck = require("efmls-configs.linters.luacheck")
  local stylua = require("efmls-configs.formatters.stylua")

  local flake8 = require("efmls-configs.linters.flake8")
  local black = require("efmls-configs.formatters.black")

  local prettier_d = require("efmls-configs.formatters.prettier_d")
  local eslint_d = require("efmls-configs.linters.eslint_d")

  local fixjson = require("efmls-configs.formatters.fixjson")

  local shellcheck = require("efmls-configs.linters.shellcheck")
  local shfmt = require("efmls-configs.formatters.shfmt")

  local cpplint = require("efmls-configs.linters.cpplint")
  local clangfmt = require("efmls-configs.formatters.clang_format")

  local go_revive = require("efmls-configs.linters.go_revive")
  local gofumpt = require("efmls-configs.formatters.gofumpt")

  vim.lsp.config("efm", {
    filetypes = {
      "c",
      "cpp",
      "css",
      "go",
      "html",
      "javascript",
      "javascriptreact",
      "json",
      "jsonc",
      "lua",
      "markdown",
      "python",
      "sh",
      "typescript",
      "typescriptreact",
      "vue",
      "svelte",
    },
    init_options = { documentFormatting = true },
    settings = {
      languages = {
        c = { clangfmt, cpplint },
        go = { gofumpt, go_revive },
        cpp = { clangfmt, cpplint },
        css = { prettier_d },
        html = { prettier_d },
        javascript = { eslint_d, prettier_d },
        javascriptreact = { eslint_d, prettier_d },
        json = { eslint_d, fixjson },
        jsonc = { eslint_d, fixjson },
        lua = { luacheck, stylua },
        markdown = { prettier_d },
        python = { flake8, black },
        sh = { shellcheck, shfmt },
        typescript = { eslint_d, prettier_d },
        typescriptreact = { eslint_d, prettier_d },
        vue = { eslint_d, prettier_d },
        svelte = { eslint_d, prettier_d },
      },
    },
  })
end

vim.lsp.enable({
  "lua_ls",
  "pyright",
  "bashls",
  "ts_ls",
  "gopls",
  "clangd",
  "efm",
  "jdtls",
})

-- ===========================================================
-- Conform plugin config

conform.setup({
  formatters_by_ft = {
    javascript = { "prettier", stop_after_first = true },
    typescript = { "prettier", stop_after_first = true },
    javascriptreact = { "prettier", stop_after_first = true },
    typescriptreact = { "prettier", stop_after_first = true },
    css = { "prettier" },
    scss = { "prettier" },
    json = { "prettier" },
    yaml = { "yamlfmt" },
    markdown = { "prettier" },
    lua = { "stylua" },
    kotlin = { "ktlint" },
    cpp = { "clang-format" },
    c = { "clang-format" },
    java = { "palantir-java-format" },
    xml = { "xmlformatter" },
  },
  format_on_save = {
    lsp_format = "fallback",
    async = false,
    timeout_ms = 500,
  },
  formatters = {
    clang_format = {
      command = "clang-format",
      args = { "--assume-filename", "$FILENAME" },
      stdin = true,
    },
    eslint_d = {
      meta = {
        url = "https://github.com/mantoni/eslint_d.js/",
        description = "Like ESLint, but faster.",
      },
      command = util.from_node_modules("eslint_d"),
      args = { "--fix-to-stdout", "--stdin", "--stdin-filename", "$FILENAME" },
      require_cwd = true,
      cwd = util.root_file({
        "eslint.config.mjs",
        "eslint.config.js",
        "package.json",
        "eslintrc.json",
        "eslintrc.js",
        ".eslintrc.js",
        "eslintrc",
      }),
    },
    prettier = {
      -- cwd means "config working directory"
      require_cwd = true,

      cwd = util.root_file({
        ".prettierrc",
        ".prettierrc.json",
        ".prettierrc.yml",
        ".prettierrc.yaml",
        ".prettierrc.json5",
        ".prettierrc.js",
        ".prettierrc.cjs",
        ".prettierrc.mjs",
        ".prettierrc.toml",
        "prettier.config.js",
        "prettier.config.cjs",
        "prettier.config.mjs",
      }),
    },
  },
})

require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
  completion = {
    completeopt = "menu,menuone,preview,noselect",
  },

  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
      cmp.resubscribe({ "TextChangedI", "TextChangedP" })
      require("cmp.config").set_onetime({ sources = {} })
    end,
  },

  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },

  mapping = cmp.mapping.preset.insert({
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-j>"] = cmp.mapping.scroll_docs(1),
    ["<C-k>"] = cmp.mapping.scroll_docs(-1),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<C-b>"] = cmp.mapping.select_prev_item(),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),

  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "nvim_lsp_signature_help" },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "path" },
  }),
})

cmp.setup.cmdline("/", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = "buffer" },
  },
})

cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = "path" },
  }, {
    {
      name = "cmdline",
      option = {
        ignore_cmds = { "Man", "!" },
      },
    },
  }),
})

-- ===========================================================
-- Lint config to use eslint from the project
lint.linters_by_ft = {
  typescript = { "eslint_d", "eslint" },
  javascript = { "eslint_d", "eslint" },
  typescriptreact = { "eslint_d", "eslint" },
  javascriptreact = { "eslint_d", "eslint" },
  -- kotlin = { 'ktlint' },
}
local eslint = lint.linters.eslint_d
-- local eslint = util.from_node_modules("eslint_d")
eslint.args = {
  -- "--no-warn-ignored", -- <-- this is the key argument
  "--ignore", -- <-- this is the key argument
  "--format",
  "json",
  "--stdin",
  "--stdin-filename",
  function()
    return vim.api.nvim_buf_get_name(0)
  end,
}

local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
  group = lint_augroup,
  callback = function()
    lint.try_lint()
  end,
})
