-- barbar must not auto-setup on load; setup() below is the single source of options.
vim.g.barbar_auto_setup = false

vim.pack.add({
  { src = "https://github.com/romgrk/barbar.nvim" },
})

require("barbar").setup({
  animation = false,
  focus_on_close = "previous",
  insert_at_end = true,
  icons = {
    buffer_index = false,
    diagnostics = {
      [vim.diagnostic.severity.ERROR] = { enabled = true, icon = " " },
      [vim.diagnostic.severity.WARN] = { enabled = true, icon = " " },
    },
    gitsigns = {
      added = { enabled = true, icon = "+" },
      changed = { enabled = true, icon = "~" },
      deleted = { enabled = true, icon = "-" },
    },
    pinned = { button = "", filename = true },
  },
  -- neo-tree lives on the right; barbar detects the side and offsets the tabline.
  sidebar_filetypes = {
    ["neo-tree"] = { event = "BufWipeout" },
  },
})

local keymap = vim.keymap
local opts = function(desc)
  return { silent = true, desc = desc }
end

-- Navigate in barbar's order (replaces :bnext/:bprev, which ignore reordering)
keymap.set("n", "<S-l>", "<Cmd>BufferNext<CR>", opts("Next buffer"))
keymap.set("n", "<S-h>", "<Cmd>BufferPrevious<CR>", opts("Previous buffer"))

-- Re-order
keymap.set("n", "<A-.>", "<Cmd>BufferMoveNext<CR>", opts("Move buffer right"))
keymap.set("n", "<A-,>", "<Cmd>BufferMovePrevious<CR>", opts("Move buffer left"))

-- Go to buffer by position
for i = 1, 9 do
  keymap.set("n", "<A-" .. i .. ">", "<Cmd>BufferGoto " .. i .. "<CR>", opts("Go to buffer " .. i))
end
keymap.set("n", "<A-0>", "<Cmd>BufferLast<CR>", opts("Go to last buffer"))

-- Pin, pick, close
keymap.set("n", "<A-p>", "<Cmd>BufferPin<CR>", opts("Pin/unpin buffer"))
keymap.set("n", "<leader>bp", "<Cmd>BufferPick<CR>", opts("Pick buffer"))
keymap.set("n", "<A-c>", "<Cmd>BufferClose<CR>", opts("Close buffer"))
keymap.set("n", "<leader>bo", "<Cmd>BufferCloseAllButCurrentOrPinned<CR>", opts("Close other buffers"))
keymap.set("n", "<leader>br", "<Cmd>BufferRestore<CR>", opts("Restore closed buffer"))
