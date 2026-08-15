vim.g.mapleader = "\\"
vim.g.maplocalleader = "\\"

vim.pack.add({
  { src = "https://www.github.com/echasnovski/mini.nvim" },
  { src = "https://github.com/brenoprata10/nvim-highlight-colors" },
  -- ============================================================================
  {
    src = "https://github.com/JavaHello/spring-boot.nvim",
    version = "218c0c26c14d99feca778e4d13f5ec3e8b1b60f0",
  },
  { src = "https://github.com/mfussenegger/nvim-dap" },
  { src = "https://github.com/nvim-java/nvim-java" },
  { src = "https://github.com/sphamba/smear-cursor.nvim" },
  { src = "https://github.com/coder/claudecode.nvim" },

  -- ============================================================================
  -- Dependencies for some plugins
  -- ============================================================================
  { src = "https://github.com/nvim-tree/nvim-web-devicons" },
  { src = "https://github.com/nvim-lua/plenary.nvim" },
  -- Dependency to claude code plugin
  { src = "https://github.com/folke/snacks.nvim" },
})

require("smoothvim.config")
require("smoothvim.packs")

require("mini.notify").setup({
  window = {
    config = {
      anchor = "SE",
      col = vim.o.columns,
      row = vim.o.lines - 2,
    },
  },
})
require("mini.icons").setup({}) -- icon provider used by neo-tree/lualine/etc.
require("mini.pairs").setup({}) -- auto-close brackets/quotes
require("mini.comment").setup({}) -- gc/gcc comment toggling
require("mini.surround").setup({}) -- add/change/delete surrounding pairs (quotes, tags, ...)

require("java").setup()
require("nvim-highlight-colors").setup({})

-- ============================================================================
-- PLUGIN CONFIGS
-- ============================================================================
require("claudecode").setup({
  terminal = {
    provider = "snacks", -- você já tem o snacks; tira o Claude da briga de splits
    snacks_win_opts = {
      position = "left", -- painel à esquerda, porém FLUTUANTE (não entra na grade de splits)
      width = 0.35, -- 35% da largura
      height = 1.0, -- altura cheia
      border = "rounded",
      keys = {
        -- Esconde o Claude (sem matar o processo) direto do modo terminal.
        -- <leader> não funciona bem em modo terminal, por isso um Ctrl.
        claude_hide = {
          "<C-,>",
          function(self)
            self:hide()
          end,
          mode = "t",
          desc = "Esconder Claude",
        },
      },
    },
  },
})
vim.keymap.set({ "n", "x", "t" }, "<leader>cl", "<cmd>ClaudeCodeFocus<cr>", { desc = "Claude Code (toggle/focus)" })

local Snacks = require("snacks")
vim.keymap.set({ "n", "t" }, "<leader>tt", function()
  Snacks.terminal.toggle(nil, { win = { position = "float", border = "rounded" } })
end, { desc = "Toggle terminal (snacks, float)" })

require("smear_cursor").setup({
  never_draw_over_target = true, -- don't smear across the actual cursor target (e.g. cmdline)
  smear_insert_mode = false, -- disable the trailing effect while typing in insert mode
  cursor_color = "#FF48B0",
})
