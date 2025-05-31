return {
  "romgrk/barbar.nvim",
  config = function()
    require("barbar").setup({
      animation = true,
      auto_hide = false,
      insert_at_end = true,
      no_name_title = "Empty",
    })
  end,
}
