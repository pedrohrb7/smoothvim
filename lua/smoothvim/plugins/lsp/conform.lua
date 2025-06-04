return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local conform = require("conform")
    local util = require("conform.util")

    conform.setup({
      formatters_by_ft = {
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        css = { "prettier" },
        scss = { "prettier" },
        json = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
        lua = { "stylua" },
        -- java = { 'clang-format' },
        -- graphql = { 'prettier' },
        -- kotlin = { 'ktlint' },
      },
      format_on_save = {
        lsp_fallback = true,
        async = false,
        timeout_ms = 500,
      },
      formatters = {
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
      },
    })
  end,
}
