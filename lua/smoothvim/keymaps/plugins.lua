-- Keymaps that exec plugins

local keymap = vim.keymap -- for conciseness
local opts = { noremap = true, silent = true }

--Neo-tree plugin
keymap.set("n", "<leader>ee", ":Neotree toggle<CR>", opts, { desc = "Toggle file explorer" }) -- toggle file explorer
keymap.set("n", "<leader>bf", ":Neotree buffers reveal float<CR>", opts, { desc = "Reveal buffers in modal" })
keymap.set("n", "--", ":Neotree reveal<CR>", opts, { desc = "Reveal file under cursos" })

-- Lint
keymap.set("n", "<leader>ll", function()
  require("lint").try_lint()
end, { desc = "Trigger linting in current buffer" })

-- Telescope plugin
keymap.set("n", "<leader>ff", "<cmd>Telescop find_files<CR>", opts, { desc = "Telescope Find file" })
keymap.set("n", "<leader>fg", "<cmd>Telescop live_grep<CR>", { desc = "Telescope Search by word" })
keymap.set("n", "<leader>fb", "<cmd>Telescop buffers<CR>", { desc = "Search in open buffers" })
keymap.set("n", "<leader>fs", "<cmd>Telescop aerial<CR>", { desc = "Search symbols in current buffer" })

-- Trouble plugin
keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", opts, { desc = "Diagnostics (Trouble)" })
keymap.set(
  "n",
  "<leader>xX",
  "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
  opts,
  { desc = "Buffer Diagnostics (Trouble)" }
)

-- Theme manager plugin
keymap.set("n", "<leader>tt", "<cmd>Themery<CR>", opts, { desc = "Themery choose theme" })

-- Conform Plugin (formatting.lua)
keymap.set("n", "<leader>mp", function()
  local conform = require("conform")
  conform.format({
    lsp_fallback = true,
    async = false,
    timeout_ms = 500,
  })
end, { desc = "Conform Format file or range" })

-- Noice Plugin
-- This will help when a lot of notifications appears
keymap.set("n", "<leader>nd", ":NoiceDismiss<CR>", opts, { desc = "Noice Dismiss notification" })
