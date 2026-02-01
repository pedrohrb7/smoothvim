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
}

return {
  cmd = { "tailwindcss-language-server", "--stdio" },
  filetypes = {
    -- html
    "ejs",
    "html",
    "htmlangular",
    "heex",
    "markdown",
    "mustache",
    -- css
    "css",
    "less",
    "postcss",
    "sass",
    "scss",
    "stylus",
    -- js
    "javascript",
    "javascriptreact",
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
