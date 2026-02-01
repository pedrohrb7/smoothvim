vim.pack.add({
  { src = "https://github.com/nvim-lualine/lualine.nvim" }
})


local luaLine = require("lualine")
    -- To enable code symbols uncomment this and add to c section in sections
    -- local symbols = require("trouble").statusline({
    --   mode = "lsp_document_symbols",
    --   groups = {},
    --   title = false,
    --   filter = { range = true },
    --   format = "{kind_icon}{symbol.name:Normal}",
    --   -- The following line is needed to fix the background color
    --   -- Set it to the lualine section you want to use
    --   hl_group = "lualine_c_normal",
    -- })

    -- Config
    local config = {
      options = {
        icons_enabled = true,
        disabled_filetypes = {
          statusline = { "neo-tree", "alpha" },
        },
        component_separators = "",
        section_separators = "",
      },
      sections = {
        lualine_a = { { "mode", icon = "  ", separator = { left = "" }, right_padding = 2 } },
        lualine_b = { "filename", "branch", "diff" },
        lualine_c = {},
        lualine_x = {},
        lualine_y = { "diagnostics", "filetype", "progress" },
        lualine_z = {
          { "location", separator = { right = "" }, left_padding = 2 },
        },
      },
      inactive_sections = {
        lualine_a = {  },
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
