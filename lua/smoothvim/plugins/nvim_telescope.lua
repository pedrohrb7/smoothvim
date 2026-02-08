return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    local trouble_telescope = require("trouble.sources.telescope")

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

    telescope.load_extension("fzf")

    local keymap = vim.keymap
    local opts = { noremap = true, silent = true }

    keymap.set("n", "<leader>ff", "<cmd>Telescop find_files<CR>", opts) -- "Telescope Find file" })
    keymap.set("n", "<leader>fw", "<cmd>Telescop live_grep<CR>", opts) -- "Telescope Search by word" })
    keymap.set("n", "<leader>fb", "<cmd>Telescop buffers<CR>", opts) -- "Search in open buffers" })
  end,
}
