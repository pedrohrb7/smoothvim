return {
  -- cmp config
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdLine",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
      "onsails/lspkind.nvim",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      local lspkind = require("lspkind")

      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        completion = {
          completeopt = "menu,menuone,preview,noselect",
        },

        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },

        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },

        mapping = cmp.mapping.preset.insert({
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<C-u>"] = cmp.mapping.scroll_docs(-4),
          ["<C-d>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),

        sources = cmp.config.sources({
          { name = "copilot" },
          { name = "nvim_lsp" },
          { name = "nvim_lsp_signature_help" },
          { name = "luasnip" }, -- For luasnip users.
          { name = "buffer" },
          { name = "path" },
        }),

        formatting = {
          format = lspkind.cmp_format({
            mode = "symbol_text", -- show only symbol annotations
            maxwidth = {
              -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
              -- can also be a function to dynamically calculate max width such as
              -- menu = function() return math.floor(0.45 * vim.o.columns) end,
              menu = 50, -- leading text (labelDetails)
              abbr = 50, -- actual suggestion item
            },
            ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
            show_labelDetails = true, -- show labelDetails in menu. Disabled by default
            symbol_map = { Copilot = "" },
          }),
        },
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
    end,
  },

  -- conform config
  {
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
          yaml = { "yamlfmt" },
          markdown = { "prettier" },
          lua = { "stylua" },
          kotlin = { "ktlint" },
          cpp = { "clang-format" },
          c = { "clang-format" },
          java = { "clang-format" },
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
  },

  -- lsp config
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      { "antosha417/nvim-lsp-file-operations", config = true },
    },
  },

  -- lsp signature config
  {
    "ray-x/lsp_signature.nvim",
    event = "InsertEnter",
    opts = {
      bind = true,
      handler_opts = {
        border = "rounded",
      },
    },
    config = function(_, opts)
      require("lsp_signature").setup(opts)
    end,
  },

  -- lint config
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lint = require("lint")

      lint.linters_by_ft = {
        typescript = { "eslint_d", "eslint" },
        javascript = { "eslint_d", "eslint" },
        typescriptreact = { "eslint_d", "eslint" },
        javascriptreact = { "eslint_d", "eslint" },
        -- kotlin = { 'ktlint' },
      }
      local eslint = lint.linters.eslint_d

      eslint.args = {
        "--no-warn-ignored", -- <-- this is the key argument
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
          -- Get the full path of the current buffer
          local file_path = vim.api.nvim_buf_get_name(0)
          if not file_path or file_path == "" then
            return
          end

          -- Find 'package.json' by searching upwards from the current file's directory
          -- vim.fs.find returns a table (list) of paths
          local package_json_paths = vim.fs.find("package.json", {
            upward = true,
            path = vim.fn.fnamemodify(file_path, ":h"),
            type = "file",
            limit = 1,
          })

          -- Check if the search returned any results
          if #package_json_paths > 0 then
            -- Get the first result from the table
            local package_json_path = package_json_paths[1]

            -- Get the directory containing package.json
            local project_dir = vim.fn.fnamemodify(package_json_path, ":h")

            if project_dir then
              lint.try_lint()
            end
          end
        end,
      })
    end,
  },
}
