return {
  -- Darkrose
  {
    "water-sucks/darkrose.nvim",
    lazy = false,
    priority = 1000,
  },
  -- Kanagawa
  {
    "rebelot/kanagawa.nvim",
    config = function()
      require("kanagawa").setup({})
    end,
  },

  -- ZitchDog theme
  {
    "theamallalgi/zitchdog",
    lazy = false,
    priority = 1000,
  },

  -- Tokyonight theme
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
    config = function()
      local tkn = require("tokyonight")
      tkn.setup({
        -- set to "false" to see colors better
        transparent = true,
        styles = {
          -- Background styles. Can be "dark", "transparent" or "normal"
          sidebars = "transparent", -- style for sidebars, see below
          -- floats = 'transparent', -- style for floating windows
          comments = { italic = true, bold = true },
          functions = { italic = true },
          variables = { italic = true },
        },
      })
    end,
  },

  -- Nord theme
  {
    "gbprod/nord.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("nord").setup({
        transparent = true,
        styles = {
          -- Style to be applied to different syntax groups
          -- Value is any valid attr-list value for `:help nvim_set_hl`
          comments = { bold = true },
          keywords = { italic = true },
          functions = { italic = true },
          variables = { italic = true },

          bufferline = {
            current = { bold = true },
            modified = { italic = true },
          },
        },
      })
    end,
  },

  -- OneDark
  {
    "olimorris/onedarkpro.nvim",
    priority = 1000, -- Ensure it loads first
    config = function()
      require("onedarkpro").setup({
        styles = {
          types = "NONE",
          methods = "NONE",
          numbers = "NONE",
          strings = "NONE",
          comments = "italic",
          keywords = "bold,italic",
          constants = "NONE",
          functions = "italic",
          operators = "NONE",
          variables = "NONE",
          parameters = "NONE",
          conditionals = "italic",
          virtual_text = "NONE",
        },
        options = {
          cursorline = false, -- Use cursorline highlighting?
          transparency = false, -- Use a transparent background?
          terminal_colors = true, -- Use the theme's colors for Neovim's :terminal?
          lualine_transparency = true, -- Center bar transparency?
          highlight_inactive_windows = false, -- When the window is out of focus, change the normal background?
        },
      })
    end,
  },
}
