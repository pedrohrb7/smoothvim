-- Leader used for all custom <leader>-prefixed keymaps (see smoothvim.config.keymaps)
vim.g.mapleader = "\\"
vim.g.maplocalleader = "\\"

-- Declares every plugin to fetch/load via Neovim's built-in plugin manager (vim.pack).
-- Setup/config for these happens below and in smoothvim.packs; this block only declares sources.
vim.pack.add({
  { src = "https://www.github.com/echasnovski/mini.nvim" },
  -- ============================================================================
  -- theme packages
  { src = "https://github.com/rose-pine/neovim" },
  { src = "https://github.com/folke/tokyonight.nvim" },
  { src = "https://github.com/brenoprata10/nvim-highlight-colors" },
  -- ============================================================================
  {
    src = "https://github.com/JavaHello/spring-boot.nvim",
    -- pinned commit: avoids breakage from upstream changes until bumped intentionally
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

-- smoothvim.config: core options, keymaps, autocmds
-- smoothvim.packs: per-plugin setup for lualine, telescope, lsp, neo-tree, git
require("smoothvim.config")
require("smoothvim.packs")

-- mini.nvim modules: each submodule is set up independently, only what's needed
-- notify: popup notifications, anchored bottom-right (SE) above the last two lines
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
require("nvim-highlight-colors").setup({})
require("java").setup() -- nvim-java: JDTLS/Java LSP wiring, must run before LSP attaches to Java files

-- ============================================================================
-- PLUGIN CONFIGS
-- ============================================================================
require("claudecode").setup()
vim.keymap.set("n", "<leader>cl", "<cmd>ClaudeCode<CR>", { desc = "Toggle Claude Code" })

require("smear_cursor").setup({
  never_draw_over_target = true, -- don't smear across the actual cursor target (e.g. cmdline)
  smear_insert_mode = false, -- disable the trailing effect while typing in insert mode
  cursor_color = "#FF48B0",
})

require("tokyonight").setup({
  transparent = true,
  styles = {
    -- Background styles. Can be "dark", "transparent" or "normal"
    sidebars = "transparent",
    floats = "dark",
  },
  lualine_bold = true,
})

require("rose-pine").setup({
  styles = {
    transparency = false,
  },
})

-- Active colorscheme; rose-pine above is configured but not applied
vim.cmd.colorscheme("tokyonight")
