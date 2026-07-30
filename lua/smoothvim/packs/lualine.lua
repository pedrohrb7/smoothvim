vim.pack.add({
  { src = "https://github.com/nvim-lualine/lualine.nvim" },
})

local luaLine = require("lualine")
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
    -- lualine_b = { "filename", "branch", "diff" },
    lualine_b = {
      "filename",
      -- Branch do repo do ARQUIVO atual
      {
        function()
          local dict = vim.b.gitsigns_status_dict
          return dict and dict.head or ""
        end,
        icon = "",
        cond = function()
          local dict = vim.b.gitsigns_status_dict
          return dict ~= nil and dict.head ~= nil and dict.head ~= ""
        end,
      },
      -- Contagem de diff vinda do gitsigns (por buffer), não do cwd
      {
        "diff",
        source = function()
          local gs = vim.b.gitsigns_status_dict
          if gs then
            return { added = gs.added, modified = gs.changed, removed = gs.removed }
          end
        end,
      },
    },
    lualine_c = {},
    lualine_x = {},
    lualine_y = { "diagnostics", "filetype", "progress" },
    lualine_z = {
      { "location", separator = { right = "" }, left_padding = 2 },
    },
  },
  inactive_sections = {
    lualine_a = {},
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
