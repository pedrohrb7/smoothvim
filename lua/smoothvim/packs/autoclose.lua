vim.pack.add({
  { src = "https://github.com/windwp/nvim-autopairs" },
  -- { src = "https://github.com/windwp/nvim-ts-autotag" },
})

-- local cmp_autopairs = require("nvim-autopairs.completion.cmp")
-- local cmp = require("cmp")

local autopairs = require("nvim-autopairs")
autopairs.setup({
  check_ts = true, -- enable treesitter
  ts_config = {
    lua = { "string" }, -- don't add pairs in lua string treesitter nodes
    javascript = { "template_string" }, -- don't add pairs in javscript template_string treesitter nodes
    java = false, -- don't check treesitter on java
  },
})

-- cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

-- require("nvim-ts-autotag").setup({
--   opts = {
--     enable_close = true,
--     enable_rename = true,
--     enable_close_on_slash = false,
--   },
-- })
