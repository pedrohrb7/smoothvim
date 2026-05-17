vim.pack.add({
  { src = "https://github.com/nvim-telescope/telescope.nvim" },
  { src = "https://github.com/nvim-telescope/telescope-ui-select.nvim" },
})

local telescope = require("telescope")
local actions = require("telescope.actions")
local builtin = require('telescope.builtin')

telescope.setup({
  defaults = {
    path_display = { "smart" },
    file_ignore_patterns = {
      "node_modules",
      ".next",
      "dist",
      "build",
      "bundle",
      ".git",
      ".yarn",
    },
    mappings = {
      i = {
        ["<C-k>"] = actions.move_selection_previous, -- move to prev result
        ["<C-j>"] = actions.move_selection_next, -- move to next result
      },
    },
  },
  pickers = {
    colorscheme = {
      enable_preview = true,
    },
    find_files = {
      theme = "ivy",
      hidden = true,
    },
    live_grep = {
      theme = "ivy",
      hidden = true,
    },
    buffers = {
      theme = "ivy",
      hidden = true,
    },
    git_status = {
      theme = "ivy",
      hidden = true,
    },
    diagnostics = {
      theme = "ivy",
      hidden = true,
    },
  },
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_ivy({}),
    },
  },
})

telescope.load_extension("ui-select")

local keymap = vim.keymap
local opts = { noremap = true, silent = true }

keymap.set("n", "<leader>ff", builtin.find_files, opts) -- Telescope Find file" })
keymap.set("n", "<leader>fw", builtin.live_grep, opts) -- Telescope Search by word" })
keymap.set("n", "<leader>fb", builtin.buffers, opts) -- Search in open buffers" })
keymap.set("n", "<leader>fg", builtin.git_status, opts) -- Search in git edited buffers
keymap.set('n', '<leader>fd', builtin.diagnostics, opts) -- Telescope show diagnostics
