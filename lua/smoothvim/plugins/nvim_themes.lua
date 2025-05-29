return {
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
        style = "storm",
        -- transparent = true,
        styles = {
          -- Background styles. Can be "dark", "transparent" or "normal"
          -- sidebars = "transparent", -- style for sidebars, see below
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
        -- transparent = true,
        styles = {
          -- Style to be applied to different syntax groups
          -- Value is any valid attr-list value for `:help nvim_set_hl`
          comments = { bold = true },
          keywords = {},
          functions = { italic = true },
          variables = {},
        },
      })
    end,
  },

  -- Black metal theme
  {
    "metalelf0/base16-black-metal-scheme",
  },
}
