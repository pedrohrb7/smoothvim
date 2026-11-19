-- barbar runs setup() on its own when loaded unless this is false; setup is called explicitly below.
vim.g.barbar_auto_setup = false

vim.pack.add({
  { src = "https://github.com/romgrk/barbar.nvim" },
})

require("barbar").setup({
  animation = true,
  auto_hide = false,
  insert_at_end = true,
  no_name_title = "Empty",
})

vim.keymap.set("n", "<A-c>", "<Cmd>BufferClose<CR>", { desc = "close buffer tab", silent = true })
