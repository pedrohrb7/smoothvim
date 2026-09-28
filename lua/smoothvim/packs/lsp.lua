vim.pack.add({
  { src = "https://github.com/williamboman/mason.nvim" },
  { src = "https://github.com/williamboman/mason-lspconfig.nvim" },

  { src = "https://github.com/creativenull/efmls-configs-nvim" },

  { src = "https://github.com/neovim/nvim-lspconfig" },
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
-- automatic_enable = false: server enabling is done explicitly via the
-- vim.lsp.enable({...}) call below, so an install via Mason alone doesn't
-- silently start a server we never configured.
require("mason-lspconfig").setup({ automatic_enable = false })
require("lsp-file-operations").setup()

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

  if client:supports_method("textDocument/inlayHint") then
    vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
  end

  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
  vim.keymap.set(
    "n",
    "<leader>d",
    vim.diagnostic.open_float,
    vim.tbl_extend("force", opts, { desc = "Show line diagnostics" })
  )
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
        includeInlayParameterNameHints = "literals",
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = false,
        includeInlayVariableTypeHints = false,
        includeInlayVariableTypeHintsWhenTypeMatchesName = false,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = false,
        includeInlayEnumMemberValueHints = false,
      },
    },
  },
})
vim.lsp.config("gopls", {})
vim.lsp.config("clangd", {})

do
  local luacheck = require("efmls-configs.linters.luacheck")

  local flake8 = require("efmls-configs.linters.flake8")
  local black = require("efmls-configs.formatters.black")

  local prettier_d = require("efmls-configs.formatters.prettier_d")
  -- Plain eslint, not eslint_d: eslint_d is a shared long-lived daemon, and
  -- efmls-configs resolves its local-binary path once at startup (relative to
  -- Neovim's cwd), so in a multi-folder workspace with projects on different
  -- ESLint majors (e.g. v8 vs v9) the daemon gets reused across incompatible
  -- versions and throws (e.g. "scopeManager.addGlobals is not a function").
  -- Plain eslint spawns a fresh process per lint, so it can't cross-poison.
  local eslint = require("efmls-configs.linters.eslint")

  local fixjson = require("efmls-configs.formatters.fixjson")

  local shellcheck = require("efmls-configs.linters.shellcheck")
  local shfmt = require("efmls-configs.formatters.shfmt")

  local cpplint = require("efmls-configs.linters.cpplint")

  local go_revive = require("efmls-configs.linters.go_revive")
  local gofumpt = require("efmls-configs.formatters.gofumpt")

  vim.lsp.config("efm", {
    -- Prefer the nearest subproject marker over the parent folder's .git so efm
    -- (and the eslint_d/prettier_d tools it drives) anchors per-subproject in a
    -- multi-folder workspace. '.git' stays as a fallback for non-JS/TS projects.
    root_markers = {
      {
        "eslint.config.js",
        "eslint.config.mjs",
        "eslint.config.cjs",
        ".eslintrc",
        ".eslintrc.js",
        ".eslintrc.cjs",
        ".eslintrc.json",
        "package.json",
        "pyproject.toml",
        "go.mod",
        "Cargo.toml",
      },
      { ".git" },
    },
    -- css, javascript(react), typescript(react) and markdown are deliberately
    -- absent: conform already formats them directly (see conform.setup below)
    -- and, once their formatter is dropped here, efm would have nothing left
    -- to do for them - attaching would just be a useless client.
    filetypes = {
      "c",
      "cpp",
      "go",
      "html",
      "json",
      "jsonc",
      "lua",
      "python",
      "sh",
      "vue",
      "svelte",
    },
    init_options = { documentFormatting = true },
    settings = {
      languages = {
        -- clangfmt/stylua/etc. dropped below wherever conform.setup already
        -- owns formatting for that filetype, to avoid two tools formatting
        -- the same file (potentially with diverging output).
        c = { cpplint },
        go = { gofumpt, go_revive },
        cpp = { cpplint },
        html = { prettier_d },
        -- eslint omitted for js/jsx/ts/tsx: nvim-lint already lints them with
        -- per-buffer local-binary + cwd resolution (see below); keeping it
        -- in efm too would double every ESLint diagnostic.
        json = { eslint, fixjson },
        jsonc = { eslint, fixjson },
        lua = { luacheck },
        python = { flake8, black },
        sh = { shellcheck, shfmt },
        vue = { eslint, prettier_d },
        svelte = { eslint, prettier_d },
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
  "dockerls",
  "jsonls",
  "cssls",
  "emmet_ls",
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
    markdown = { "prettier_md" },
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
    -- Separate from `prettier` above: markdown files (notes, docs, this very
    -- config repo) usually live outside any JS/TS project and have no
    -- .prettierrc, so require_cwd=true would silently skip them entirely.
    -- Prettier formats markdown fine with its own defaults, so don't require
    -- a project config for it.
    prettier_md = vim.tbl_deep_extend("force", require("conform.formatters.prettier"), {
      require_cwd = false,
    }),
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
    { name = "dotenv" },
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
-- Lint config to use eslint from the project.
-- Plain eslint only, not eslint_d: eslint_d is a shared long-lived daemon and
-- in a multi-folder workspace with projects on different ESLint majors (e.g.
-- v8 vs v9), it gets reused across incompatible versions and throws (e.g.
-- "scopeManager.addGlobals is not a function"). Plain eslint spawns a fresh
-- process per lint, so it can't cross-poison between subprojects.
lint.linters_by_ft = {
  typescript = { "eslint" },
  javascript = { "eslint" },
  typescriptreact = { "eslint" },
  javascriptreact = { "eslint" },
  -- kotlin = { 'ktlint' },
}
-- Resolve the eslint binary from the nearest node_modules/.bin walking up from
-- the buffer being linted, not from getcwd(). In a multi-folder workspace
-- getcwd() is the parent folder that opened Neovim, so the default
-- './node_modules/.bin/eslint' lookup used by nvim-lint's bundled linter
-- misses each subproject's local install.
lint.linters.eslint.cmd = function()
  local bufname = vim.api.nvim_buf_get_name(0)
  local root = vim.fs.root(bufname, "node_modules")
  if root then
    local local_bin = root .. "/node_modules/.bin/eslint"
    if vim.fn.executable(local_bin) == 1 then
      return local_bin
    end
  end
  return "eslint"
end

local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
  group = lint_augroup,
  callback = function()
    -- ESLint's own config discovery (flat config in particular) walks up from
    -- the process cwd, not from --stdin-filename. In a multi-folder workspace
    -- Neovim's cwd is the parent folder that was opened, so without this the
    -- linter process silently finds no config and reports zero diagnostics.
    local bufname = vim.api.nvim_buf_get_name(0)
    local cwd = vim.fs.root(bufname, "node_modules") or vim.fn.getcwd()
    lint.try_lint(nil, { cwd = cwd })
  end,
})
