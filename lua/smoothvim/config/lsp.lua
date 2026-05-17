-- ============================================================================
-- LSP, Linting, Formatting & Completion
-- ============================================================================
vim.pack.add({
  { src = "https://www.github.com/neovim/nvim-lspconfig" },
  { src = "https://github.com/creativenull/efmls-configs-nvim" },
  { src = "https://www.github.com/ibhagwan/fzf-lua" },
  { src = "https://github.com/mfussenegger/nvim-lint" },
  {
    src = "https://github.com/saghen/blink.cmp",
    version = vim.version.range("1.*"),
  },
})

vim.lsp.config["*"] = {
  capabilities = require("blink.cmp").get_lsp_capabilities(),
}

vim.lsp.config("cssls", {})
vim.lsp.config("jsonls", {})
vim.lsp.config("dockerls", {})
vim.lsp.config("pyright", {})
vim.lsp.config("gopls", {})
vim.lsp.config("clangd", {})
vim.lsp.config("bashls", {})
vim.lsp.config("ts_ls", {
  filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact" },
  single_file_support = false,
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
vim.lsp.config("emmet_ls", {})
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
      format = { enable = true },
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

vim.lsp.enable('emmet_ls')
vim.lsp.enable("cssls")
vim.lsp.enable("jsonls")
vim.lsp.enable("dockerls")
vim.lsp.enable("pyright")
vim.lsp.enable('bashls')
vim.lsp.enable('ts_ls')
vim.lsp.enable('clangd')
vim.lsp.enable('lua_ls')

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

require("blink.cmp").setup({
  keymap = {
    preset = "none",
    ["<C-Space>"] = { "show", "hide" },
    ["<CR>"] = { "accept", "fallback" },
    ["<C-j>"] = { "select_next", "fallback" },
    ["<C-k>"] = { "select_prev", "fallback" },
    ["<Tab>"] = { "snippet_forward", "fallback" },
    ["<S-Tab>"] = { "snippet_backward", "fallback" },
  },
  appearance = { nerd_font_variant = "mono" },
  completion = { menu = { auto_show = true } },
  sources = { default = { "lsp", "path", "buffer", "snippets" } },
  snippets = {
    expand = function(snippet)
      require("luasnip").lsp_expand(snippet)
    end,
  },

  fuzzy = {
    implementation = "prefer_rust",
    prebuilt_binaries = { download = true },
  },
})

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
})

local augnouplsp = vim.api.nvim_create_augroup("UserConfig", { clear = true })

local default_keymaps = {
  { keys = "<leader>ca", func = vim.lsp.buf.code_action,   desc = "Code Actions" },
  { keys = "<leader>k",  func = vim.lsp.buf.hover,         desc = "Hover Documentation",  has = "hoverProvider" },
  { keys = "gd",         func = vim.lsp.buf.definition,    desc = "Goto Definition",      has = "definitionProvider" },
  { keys = "<leader>d",  func = vim.diagnostic.open_float, desc = "Show line diagnostics" },
  { keys = "<leader>rn", func = vim.lsp.buf.rename,        desc = "Smart rename" },
  { keys = "<leader>ft", func = vim.lsp.buf.format,        desc = "Format file" },
}

vim.api.nvim_create_autocmd("LspAttach", {
  group = augnouplsp,
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if not client then
      return
    end

    print("LSP Server: " ..
      client.name .. " | Formatting: " .. tostring(client:supports_method("textDocument/formatting")))

    local bufnr = ev.buf

    if client then
      -- Built-in completion
      if client:supports_method("textDocument/completion") then
        vim.lsp.completion.enable(true, client.id, ev.buf)
      end

      -- Inlay hints
      if client:supports_method("textDocument/inlayHint") then
        vim.lsp.inlay_hint.enable(true)
      end

      if client:supports_method("textDocument/documentColor") then
        vim.lsp.document_color.enable(true)
      end

      -- Format on save (only for specific filetypes)
      -- if client:supports_method("textDocument/formatting") then
      --   local format_filetypes = { "typescriptreact", "lua", "typescript", "javascript" }
      --   local current_ft = vim.bo[bufnr].filetype

      --   if vim.tbl_contains(format_filetypes, current_ft) then
      --     vim.api.nvim_create_autocmd("BufWritePre", {
      --       group = augnouplsp,
      --       buffer = bufnr,
      --       callback = function()
      --         vim.lsp.buf.format({ bufnr = bufnr })
      --       end,
      --     })
      --   end
      -- end

      -- if client:supports_method("textDocument/codeAction", bufnr) then
      --   vim.keymap.set("n", "<leader>ft", function()
      --     vim.lsp.buf.code_action({
      --       context = { only = { "source.organizeImports" }, diagnostics = {} },
      --       apply = true,
      --       bufnr = bufnr,
      --     })
      --     vim.defer_fn(function()
      --       vim.lsp.buf.format({ bufnr = bufnr })
      --     end, 50)
      --   end, opts)
      -- end

      for _, km in ipairs(default_keymaps) do
        -- Only bind if there's no `has` requirement, or the server supports it
        if not km.has or client.server_capabilities[km.has] then
          vim.keymap.set(
            km.mode or "n",
            km.keys,
            km.func,
            { buffer = bufnr, desc = "LSP: " .. km.desc, nowait = km.nowait }
          )
        end
      end
    end
  end,
})

-- local lint = require("lint")

-- lint.linters_by_ft = {
--   typescript = { "eslint_d", "eslint" },
--   javascript = { "eslint_d", "eslint" },
--   typescriptreact = { "eslint_d", "eslint" },
--   javascriptreact = { "eslint_d", "eslint" },
-- }
-- local eslint = lint.linters.eslint_d

-- eslint.args = {
--   function()
--     return vim.api.nvim_buf_get_name(0)
--   end,
-- }
