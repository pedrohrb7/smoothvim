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
  { src = "https://github.com/coder/claudecode.nvim" },

  -- ============================================================================
  -- Dependencies for some plugins
  -- ============================================================================
  { src = "https://github.com/nvim-tree/nvim-web-devicons" },
  { src = "https://github.com/nvim-lua/plenary.nvim" },
  -- Dependency to claude code plugin
  { src = "https://github.com/folke/snacks.nvim" },
  -- Dependency to nvim-java
  { src = "https://github.com/MunifTanjim/nui.nvim" },
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
require("mini.icons").setup({}) -- icon provider used by lualine/etc.
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

local function claudecode_enforce_width()
  local ok, term = pcall(require, "claudecode.terminal")
  if not ok then
    return
  end
  local bufnr = term.get_active_terminal_bufnr()
  if not bufnr then
    return
  end
  if #vim.api.nvim_tabpage_list_wins(0) < 2 then
    return
  end
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    if vim.api.nvim_win_get_buf(win) == bufnr then
      local target = math.floor(vim.o.columns * 0.35)
      if math.abs(vim.api.nvim_win_get_width(win) - target) > 1 then
        vim.api.nvim_win_set_width(win, target)
      end
      return
    end
  end
end

vim.api.nvim_create_autocmd({ "WinNew", "WinClosed", "BufWinEnter", "VimResized" }, {
  callback = function()
    vim.schedule(claudecode_enforce_width)
  end,
})

local Snacks = require("snacks")
vim.keymap.set({ "n", "t" }, "<leader>tt", function()
  Snacks.terminal.toggle(nil, { win = { position = "float", border = "rounded" } })
end, { desc = "Toggle terminal (snacks, float)" })

vim.keymap.set({ "n", "t" }, "<leader>ld", function()
  Snacks.terminal.toggle("lazydocker", { win = { position = "float", border = "rounded" } })
end, { desc = "Toggle lazydocker (snacks, float)" })

vim.keymap.set({ "n", "t" }, "<leader>lg", function()
  Snacks.terminal.toggle("lazygit", { win = { position = "float", border = "rounded" } })
end, { desc = "Toggle lazygit (snacks, float)" })
