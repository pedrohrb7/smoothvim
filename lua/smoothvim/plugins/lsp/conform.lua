return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local conform = require("conform")
    local util = require("conform.util")

    conform.setup({
      formatters_by_ft = {
        javascript = { "prettier", stop_after_first = true },
        typescript = { "prettier", stop_after_first = true },
        javascriptreact = { "prettier", stop_after_first = true },
        typescriptreact = { "prettier", stop_after_first = true },
        css = { "prettier" },
        scss = { "prettier" },
        json = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
        lua = { "stylua" },
        kotlin = { "ktlint" },
        cpp = { "clang-format" },
        c = { "clang-format" },
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
        klint = {},
        eslint_d = {
          meta = {
            url = "https://github.com/mantoni/eslint_d.js/",
            description = "Like ESLint, but faster.",
          },
          command = util.from_node_modules("eslint_d"),
          args = { "--fix-to-stdout", "--stdin", "--stdin-filename", "$FILENAME" },
          cwd = util.root_file({
            "eslint.config.mjs",
            "eslint.config.js",
            "package.json",
            "eslintrc.json",
            "eslintrc.js",
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
  end,
}
