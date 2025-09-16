return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },

  config = function()
    local luaLine = require("lualine")
    local trouble = require("trouble")
    local solirized_dark = require("smoothvim.plugins.lualine_themes.solirized_dark")

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

    -- Config
    local config = {
      options = {
        theme = solirized_dark,
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
        lualine_c = { symbols.get },
        lualine_x = {},
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
