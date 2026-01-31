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

vim.lsp.config["lua_ls"] = {
  -- Command and arguments to start the server.
  cmd = { "lua-language-server" },
  -- Filetypes to automatically attach to.
  filetypes = { "lua" },
  -- Sets the "workspace" to the directory where any of these files is found.
  -- Files that share a root directory will reuse the LSP server connection.
  -- Nested lists indicate equal priority, see |vim.lsp.Config|.
  root_markers = { { ".luarc.json", ".luarc.jsonc" }, ".git" },
  -- Specific settings to send to the server. The schema is server-defined.
  -- Example: https://raw.githubusercontent.com/LuaLS/vscode-lua/master/setting/schema.json
  settings = {
    Lua = {
      completion = { callSnippet = "Replace" },
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
}

local TAILWIND_CONFIG = {
  -- Generic
  "tailwind.config.js",
  "tailwind.config.cjs",
  "tailwind.config.mjs",
  "tailwind.config.ts",
  "postcss.config.js",
  "postcss.config.cjs",
  "postcss.config.mjs",
  "postcss.config.ts",
  -- Django
  "theme/static_src/tailwind.config.js",
  "theme/static_src/tailwind.config.cjs",
  "theme/static_src/tailwind.config.mjs",
  "theme/static_src/tailwind.config.ts",
  "theme/static_src/postcss.config.js",
}

vim.lsp.config["tailwindcss"] = {
  cmd = { "tailwindcss-language-server", "--stdio" },
  filetypes = {
    -- html
    "aspnetcorerazor",
    "astro",
    "astro-markdown",
    "blade",
    "clojure",
    "django-html",
    "htmldjango",
    "edge",
    "eelixir", -- vim ft
    "elixir",
    "ejs",
    "erb",
    "eruby", -- vim ft
    "gohtml",
    "gohtmltmpl",
    "haml",
    "handlebars",
    "hbs",
    "html",
    "htmlangular",
    "html-eex",
    "heex",
    "jade",
    "leaf",
    "liquid",
    "markdown",
    "mdx",
    "mustache",
    "njk",
    "nunjucks",
    "php",
    "razor",
    "slim",
    "twig",
    -- css
    "css",
    "less",
    "postcss",
    "sass",
    "scss",
    "stylus",
    "sugarss",
    -- js
    "javascript",
    "javascriptreact",
    "reason",
    "rescript",
    "typescript",
    "typescriptreact",
    -- mixed
    "vue",
  },
  settings = {
    tailwindCSS = {
      validate = true,
      lint = {
        cssConflict = "warning",
        invalidApply = "error",
        invalidScreen = "error",
        invalidVariant = "error",
        invalidConfigPath = "error",
        invalidTailwindDirective = "error",
        recommendedVariantOrder = "warning",
      },
      classAttributes = {
        "class",
        "className",
        "class:list",
        "classList",
        "ngClass",
      },
      includeLanguages = {
        eelixir = "html-eex",
        elixir = "phoenix-heex",
        eruby = "erb",
        heex = "phoenix-heex",
        htmlangular = "html",
        templ = "html",
      },
    },
  },
  before_init = function(_, config)
    if not config.settings then
      config.settings = {}
    end
    if not config.settings.editor then
      config.settings.editor = {}
    end
    if not config.settings.editor.tabSize then
      config.settings.editor.tabSize = vim.lsp.util.get_effective_tabstop()
    end
  end,
  workspace_required = true,
  root_dir = function(bufnr, on_dir)
    local fname = vim.api.nvim_buf_get_name(bufnr)
    on_dir(vim.fs.dirname(vim.fs.find(TAILWIND_CONFIG, { path = fname, upward = true })[1]))
  end,
}

local lsp = vim.lsp

local ESLINT_FLAT_CONFIG = {
  "eslint.config.js",
  ".eslintrc.js",
  ".eslintrc",
  "eslint.config.mjs",
  "eslint.config.cjs",
  "eslint.config.ts",
  "eslint.config.mts",
  "eslint.config.cts",
}

local WORKSPACE_ROOT_PATTERNS = {
  ".git",
  "package.json",
  "package-lock.json",
  "yarn.json",
}

vim.lsp.config["eslint"] = {
  -- cmd = { "eslint-language-server", "--fix-to-stdout", "--stdin", "--stdin-filename", "$FILENAME" },
  -- cmd = { "eslint-language-server", "--stdio" },
  cmd = { "vscode-eslint-language-server", "--stdio" },
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.tsx",
    "vue",
    "htmlangular",
    "html",
  },
  workspace_required = true,
  on_attach = function(client, bufnr)
    vim.api.nvim_buf_create_user_command(bufnr, "LspEslintFixAll", function()
      client:request_sync("workspace/executeCommand", {
        command = "eslint.applyAllFixes",
        arguments = {
          {
            uri = vim.uri_from_bufnr(bufnr),
            version = lsp.util.buf_versions[bufnr],
          },
        },
      }, nil, bufnr)
    end, {})
  end,
  root_dir = function(bufnr, on_dir)
    local fname = vim.api.nvim_buf_get_name(bufnr)

    -- Only activate if flat config exists (ESLint 9+)
    local eslint_config = vim.fs.find(ESLINT_FLAT_CONFIG, { path = fname, upward = true })[1]
    if not eslint_config then
      on_dir(nil)
      return
    end

    -- Find workspace root
    local workspace_root = vim.fs.dirname(vim.fs.find(WORKSPACE_ROOT_PATTERNS, { path = fname, upward = true })[1])
    on_dir(workspace_root or vim.fn.getcwd())
  end,
  settings = {
    validate = "on",
    packageManager = "npm",
    useESLintClass = false,
    experimental = {
      useFlatConfig = true, -- ESLint 9+ flat config only
    },
    codeActionOnSave = {
      enable = false,
      mode = "all",
    },
    format = true,
    quiet = false,
    onIgnoredFiles = "off",
    rulesCustomizations = {},
    run = "onType",
    problems = {
      shortenToSingleLine = false,
    },
    nodePath = "",
    codeAction = {
      disableRuleComment = {
        enable = true,
        location = "separateLine",
      },
      showDocumentation = {
        enable = true,
      },
    },
  },
  before_init = function(_, config)
    local root_dir = config.root_dir
    if not root_dir then
      return
    end

    config.settings = config.settings or {}
    config.settings.workspaceFolder = {
      uri = root_dir,
      name = vim.fn.fnamemodify(root_dir, ":t"),
    }

    -- Find the nearest ESLint flat config from the current file
    local fname = vim.api.nvim_buf_get_name(0)
    local nearest_config = vim.fs.find(ESLINT_FLAT_CONFIG, { path = fname, upward = true })[1]
    local config_dir = nearest_config and vim.fs.dirname(nearest_config) or root_dir

    -- Set working directory to where the ESLint config is found
    -- This is crucial for monorepos where config might be in a subdirectory
    config.settings.workingDirectory = {
      mode = "location",
      location = config_dir,
    }
  end,
  handlers = {
    ["eslint/openDoc"] = function(_, result)
      if result then
        vim.ui.open(result.url)
      end
      return {}
    end,
    ["eslint/confirmESLintExecution"] = function(_, result)
      if not result then
        return
      end
      return 4 -- approved
    end,
    ["eslint/probeFailed"] = function()
      vim.notify("[lspconfig] ESLint probe failed.", vim.log.levels.WARN)
      return {}
    end,
  },
}

vim.lsp.config["ts_ls"] = {
  filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact" },
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
}
