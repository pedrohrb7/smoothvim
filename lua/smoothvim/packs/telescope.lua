vim.pack.add({
  { src = "https://github.com/nvim-telescope/telescope.nvim" }
})

local telescope = require("telescope")
local actions = require("telescope.actions")
local transform_mod = require("telescope.actions.mt").transform_mod

local trouble = require("trouble")
local trouble_telescope = require("trouble.sources.telescope")

-- or create your custom action
local custom_actions = transform_mod({
  open_trouble_qflist = function()
    trouble.toggle("quickfix")
  end,
})

telescope.setup({
  defaults = {
    path_display = { "smart" },
    file_ignore_patterns = {
      "node_modules",
      ".next",
      "dist",
      "bundle",
      ".git",
      ".yarn",
    },
    mappings = {
      i = {
        ["<C-k>"] = actions.move_selection_previous, -- move to prev result
        ["<C-j>"] = actions.move_selection_next, -- move to next result
        ["<C-q>"] = actions.send_selected_to_qflist + custom_actions.open_trouble_qflist,
        ["<C-t>"] = trouble_telescope.smart_open_with_trouble,
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
  },
  extensions = {},
})

local keymap = vim.keymap
local opts = { noremap = true, silent = true }

keymap.set("n", "<leader>ff", "<cmd>Telescop find_files<CR>", opts) -- "Telescope Find file" })
keymap.set("n", "<leader>fw", "<cmd>Telescop live_grep<CR>", opts) -- "Telescope Search by word" })
keymap.set("n", "<leader>fb", "<cmd>Telescop buffers<CR>", opts) -- "Search in open buffers" })
