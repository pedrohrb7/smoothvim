return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },

  config = function()
    local luaLine = require("lualine")
    local trouble = require("trouble")

    local symbols = trouble.statusline({
      mode = "lsp_document_symbols",
      groups = {},
      title = false,
      filter = { range = true },
      format = "{kind_icon}{symbol.name:Normal}",
      -- The following line is needed to fix the background color
      -- Set it to the lualine section you want to use
      hl_group = "lualine_c_normal",
    })

    local colors = {
      black = "#000000",
      maroon = "#800000",
      green = "#008000",
      olive = "#808000",
      navy = "#000080",
      purple = "#800080",
      teal = "#008080",
      silver = "#c0c0c0",
      gray = "#808080",
      red = "#ff0000",
      lime = "#00ff00",
      yellow = "#ffff00",
      blue = "#0000ff",
      light_blue = "#91d7fb",
      fuchsia = "#ff00ff",
      aqua = "#00ffff",
      white = "#ffffff",
      color1 = "#000b1e",
      color2 = "#0abdc6",
      color3 = "#d300c4",
    }

    -- Config
    local config = {
      options = {
        icons_enabled = true,
        disabled_filetypes = {
          statusline = { "neo-tree", "alpha" },
        },
        theme = {
          normal = {
            a = { fg = colors.color3, bg = colors.color1, gui = "bold" },
            b = { fg = colors.white, bg = colors.color1 },
            c = { fg = colors.purple, bg = colors.color1 },
          },
          insert = { a = { fg = colors.white, bg = colors.agua, gui = "bold" } },
          visual = { a = { fg = colors.white, bg = colors.purple, gui = "bold" } },
          replace = { a = { fg = colors.white, bg = colors.red, gui = "bold" } },
          inactive = {
            a = { fg = colors.silver, bg = colors.color1, gui = "bold" },
            b = { fg = colors.gray, bg = colors.color1 },
            c = { fg = colors.silver, bg = colors.color1 },
          },
        },
        -- section_separators = { left = "", right = "" },
        component_separators = "",
        section_separators = "",
      },
      sections = {
        -- lualine_a = { { "mode", icon = "  ", separator = { left = "" }, right_padding = 2 } },
        lualine_a = { { "mode", icon = "  ", separator = { left = "" }, right_padding = 2 } },
        lualine_b = { "filename", "branch", "diff" },
        lualine_c = { symbols.get },
        lualine_x = {},
        lualine_y = { "diagnostics", "filetype", "progress" },
        lualine_z = {
          -- { "location", separator = { right = "" }, left_padding = 2 },
          { "location", separator = { right = "" }, left_padding = 2 },
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
