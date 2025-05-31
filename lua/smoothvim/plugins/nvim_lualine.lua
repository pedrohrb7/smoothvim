return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },

  config = function()
    local luaLine = require("lualine")

    -- Config
    local config = {
      options = {
        icons_enabled = true,
        disabled_filetypes = {
          statusline = { "neo-tree", "alpha" },
        },
        component_separators = "",
        section_separators = { left = "", right = "" },
      },
      sections = {
        lualine_a = { { "mode", icon = "", separator = { left = "" }, right_padding = 2 } },
        lualine_b = { "filename", "branch", "diff" },
        lualine_c = {},
        lualine_x = { "aerial" },
        lualine_y = { "diagnostics", "filetype", "progress" },
        lualine_z = {
          { "location", separator = { right = "" }, left_padding = 2 },
        },
      },
      inactive_sections = {
        lualine_a = { "filename" },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = { "filetype" },
      },
      tabline = {},
      extensions = {},
    }

    luaLine.setup(config)
  end,
}
