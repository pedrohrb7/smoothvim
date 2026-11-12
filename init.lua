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

  -- ============================================================================
  -- Dependencies for some plugins
  -- ============================================================================
  { src = "https://github.com/nvim-tree/nvim-web-devicons" },
  { src = "https://github.com/nvim-lua/plenary.nvim" },
  -- Terminal toggles (terminal, lazygit, lazydocker)
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
