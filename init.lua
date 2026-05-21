vim.g.mapleader = "\\"
vim.g.maplocalleader = "\\"

require("smoothvim.config")
require("smoothvim.packs")

-- vim.cmd.colorscheme("")

vim.pack.add({
  "https://www.github.com/lewis6991/gitsigns.nvim",
  "https://www.github.com/echasnovski/mini.nvim",
  "https://www.github.com/nvim-tree/nvim-tree.lua",
  "https://www.github.com/echasnovski/mini.nvim",
  -- theme packages
  { src = "https://github.com/rose-pine/neovim" },
  { src = "https://github.com/folke/tokyonight.nvim" },
  {
    src = "https://github.com/nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
  },
})

require("mini.notify").setup({})
require("mini.icons").setup({})
require("mini.pairs").setup({})
require("mini.comment").setup({})
require("mini.surround").setup({})

-- ============================================================================
-- PLUGIN ( CONFIGS )
-- ============================================================================
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

vim.cmd.colorscheme("tokyonight")

local setup_treesitter = function()
  local treesitter = require("nvim-treesitter")
  treesitter.setup({})
  local ensure_installed = {
    "vim",
    "vimdoc",
    "rust",
    "c",
    "cpp",
    "go",
    "html",
    "css",
    "javascript",
    "json",
    "lua",
    "markdown",
    "python",
    "typescript",
    "vue",
    "svelte",
    "bash",
  }

  local config = require("nvim-treesitter.config")

  local already_installed = config.get_installed()
  local parsers_to_install = {}

  for _, parser in ipairs(ensure_installed) do
    if not vim.tbl_contains(already_installed, parser) then
      table.insert(parsers_to_install, parser)
    end
  end

  if #parsers_to_install > 0 then
    treesitter.install(parsers_to_install)
  end

  local group = vim.api.nvim_create_augroup("TreeSitterConfig", { clear = true })
  vim.api.nvim_create_autocmd("FileType", {
    group = group,
    callback = function(args)
      if vim.list_contains(treesitter.get_installed(), vim.treesitter.language.get_lang(args.match)) then
        vim.treesitter.start(args.buf)
      end
    end,
  })
end

setup_treesitter()
