-- Keymaps that exec plugins

local keymap = vim.keymap -- for conciseness
local opts = { noremap = true, silent = true }

--Neo-tree plugin
keymap.set("n", "<leader>ee", ":Neotree toggle<CR>", opts, { desc = "Toggle file explorer" }) -- toggle file explorer
keymap.set("n", "<leader>bf", ":Neotree buffers reveal float<CR>", opts, { desc = "Reveal buffers in modal" })
keymap.set("n", "--", ":Neotree reveal<CR>", opts, { desc = "Reveal file under cursos" })

keymap.set("n", "<leader>ll", function()
  require("lint").try_lint()
end, { desc = "Trigger linting in current buffer" })
