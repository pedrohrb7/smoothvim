-- Same as core_config but keymaps
-- Keymaps that does not exec any plugin
vim.g.mapleader = "\\"
vim.g.maplocalleader = "\\"

local keymap = vim.keymap
local opts = { noremap = true, silent = true }

keymap.set("i", "jk", "<ESC>", opts, { desc = "Exit insert mode with jk" })
keymap.set("n", "<leader>nh", ":nohl<CR>", opts, { desc = "Clear search highlights" })

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", opts, { desc = "Increment number" }) -- increment
keymap.set("n", "<leader>-", "<C-x>", opts, { desc = "Decrement number" }) -- decrement

keymap.set("n", "<C-s>", "<cmd>:update<CR>", opts, { desc = "Update file changes" })
keymap.set("n", "<C-q>", "<cmd>:q<CR>", opts, { desc = "Quit nvim" })

-- Visual Block --
-- Move text up and down
keymap.set("n", "<A-j>", ":m .+1<CR>==", opts, { desc = "move line up (normal mode)" }) -- move line up(n)
keymap.set("n", "<A-k>", ":m .-2<CR>==", opts, { desc = "move line down(normal mode)" }) -- move line down(n)
keymap.set("v", "<A-k>", ":move '<-2<CR>gv-gv", opts, { desc = "move text block up" })
keymap.set("v", "<A-j>", ":move '>+1<CR>gv-gv", opts, { desc = "move text block down" })

-- Resize window using <ctrl> arrow keys
keymap.set("n", "<C-Up>", "<cmd>resize +2<cr>", opts, { desc = "Increase Window Height" })
keymap.set("n", "<C-Down>", "<cmd>resize -2<cr>", opts, { desc = "Decrease Window Height" })
keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<cr>", opts, { desc = "Decrease Window Width" })
keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<cr>", opts, { desc = "Increase Window Width" })

-- Navigate vim panes better
keymap.set("n", "<c-k>", ":wincmd k<CR>", opts, { desc = "Go to panel above" })
keymap.set("n", "<c-j>", ":wincmd j<CR>", opts, { desc = "Go to panel below" })
keymap.set("n", "<c-h>", ":wincmd h<CR>", opts, { desc = "Go to the left panel" })
keymap.set("n", "<c-l>", ":wincmd l<CR>", opts, { desc = "Go to the right panel" })

-- Stay in indent mode
keymap.set("v", "<", "<gv", opts, { desc = "Indent mode on back" })
keymap.set("v", ">", ">gv", opts, { desc = "Indent mode on indenting" })

-- Keep last yanked when pasting
keymap.set("v", "p", '"_dP', opts)

-- insert new line
keymap.set("n", "<leader>o", "o<ESC>", opts, { desc = "insert new line below" })
keymap.set("n", "<leader>O", "O<ESC>", opts, { desc = "insert new line above" })

-- Autocommands
vim.api.nvim_create_augroup("custom_buffer", { clear = true })

-- highlight yanks
vim.api.nvim_create_autocmd("TextYankPost", {
  group = "custom_buffer",
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({ timeout = 200 })
  end,
})
