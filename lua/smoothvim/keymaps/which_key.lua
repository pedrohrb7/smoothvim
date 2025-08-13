return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    preset = "modern",
    -- delay between pressing a key and opening which-key (milliseconds)
    -- this setting is independent of vim.o.timeoutlen
    delay = 0,
    icons = {
      -- set icon mappings to true if you have a Nerd Font
      mappings = vim.g.have_nerd_font,
      -- If you are using a Nerd Font: set icons.keys to an empty table which will use the
      -- default which-key.nvim defined Nerd Font icons, otherwise define a string table
      keys = vim.g.have_nerd_font and {} or {
        Up = "<Up> ",
        Down = "<Down> ",
        Left = "<Left> ",
        Right = "<Right> ",
        C = "<C-.> ",
        M = "<M-.> ",
        D = "<D-.> ",
        S = "<S-.> ",
        CR = "<CR> ",
        Esc = "<Esc> ",
        ScrollWheelDown = "<ScrollWheelDown> ",
        ScrollWheelUp = "<ScrollWheelUp> ",
        NL = "<NL> ",
        BS = "<BS> ",
        Space = "<Space> ",
        Tab = "<Tab> ",
        F1 = "<F1>",
        F2 = "<F2>",
        F3 = "<F3>",
        F4 = "<F4>",
        F5 = "<F5>",
        F6 = "<F6>",
        F7 = "<F7>",
        F8 = "<F8>",
        F9 = "<F9>",
        F10 = "<F10>",
        F11 = "<F11>",
        F12 = "<F12>",
      },
    },
  },

  config = function(_, opts)
    local wk = require("which-key")

    wk.add({

      --Neo-tree plugin
      {
        "<leader>n",
        group = "Neotree",
        { "<leader>ne", ":Neotree toggle<CR>", desc = "Toggle file explorer" },
        { "<leader>nb", ":Neotree buffers reveal float<CR>", desc = "Reveal buffers in modal" },
        { "--", ":Neotree reveal<CR>", desc = "Reveal file under cursos" },
      },

      -- Telescope plugin
      {
        "<leader>t",
        group = "Telescope",
        { "<leader>tf", ":Telescop find_files<CR>", desc = "Telescope Find file" },
        { "<leader>tg", ":Telescop live_grep<CR>", desc = "Telescope Search by word" },
        { "<leader>tb", ":Telescop buffers<CR>", desc = "Search in open buffers" },
      },

      -- Trouble plugin
      {
        "<leader>x",
        group = "Trouble",
        { "<leader>xx", ":Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
        {
          "<leader>xX",
          ":Trouble diagnostics toggle filter.buf=0<cr>",
          desc = "Buffer Diagnostics (Trouble)",
        },
      },

      -- LazyGit / LazyDocker
      {
        "<leader>l",
        group = "Lazy",
        { "<leader>lg", ":LazyGitCurrentFile<CR>", desc = "LazyGit Current File" },
        { "<leader>ld", ":Lazydocker<CR>", desc = "LazyDocker" },
      },

      -- Terminal
      {
        "<C-t>",
        group = "Terminal",
        { "<C-t>", ":ToggleTerm<CR>", desc = "ToggleTerm on float mode" },
      },
    })

    wk.setup(opts)
  end,
}
