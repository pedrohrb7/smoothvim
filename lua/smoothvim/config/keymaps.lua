local keymap = vim.keymap -- for conciseness

keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with hl" })

-- Exit Vim's terminal mode
keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

keymap.set("n", "<C-s>", "<cmd>:w<CR>", { desc = "Update file changes" })
keymap.set("n", "<C-q>", "<cmd>:q<CR>", { desc = "Quit nvim" })

--  buffer navigation
keymap.set("n", "<S-l>", ":bnext<CR>", { desc = "better way to navigate to next buffer" })
keymap.set("n", "<S-h>", ":bprev<CR>", { desc = "better way to navigate to previous buffer" })

-- Easily split windows
vim.keymap.set("n", "<leader>wv", ":vsplit<cr>", { desc = "[W]indow Split [V]ertical" })
vim.keymap.set("n", "<leader>wh", ":split<cr>", { desc = "[W]indow Split [H]orizontal" })

-- Visual Block --
-- Move text up and down
keymap.set("n", "<A-j>", ":m .+1<CR>==", { desc = "move line up (normal mode)" }) -- move line up(n)
keymap.set("n", "<A-k>", ":m .-2<CR>==", { desc = "move line down(normal mode)" }) -- move line down(n)
keymap.set("v", "<A-k>", ":move '<-2<CR>gv-gv", { desc = "move text block up" })
keymap.set("v", "<A-j>", ":move '>+1<CR>gv-gv", { desc = "move text block down" })

-- Resize window using <ctrl> arrow keys
keymap.set("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
keymap.set("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

-- Navigate vim panes better
keymap.set("n", "<c-k>", ":wincmd k<CR>", { desc = "Go to panel above" })
keymap.set("n", "<c-j>", ":wincmd j<CR>", { desc = "Go to panel below" })
keymap.set("n", "<c-h>", ":wincmd h<CR>", { desc = "Go to the left panel" })
keymap.set("n", "<c-l>", ":wincmd l<CR>", { desc = "Go to the right panel" })

-- Stay in indent mode
keymap.set("v", "<", "<gv", { desc = "Indent mode on back" })
keymap.set("v", ">", ">gv", { desc = "Indent mode on indenting" })

-- Keep last yanked when pasting
keymap.set("v", "p", '"_dP', { noremap = true, silent = true })

-- insert new line
keymap.set("n", "<leader>o", "o<ESC>", { desc = "insert new line below" })
keymap.set("n", "<leader>O", "O<ESC>", { desc = "insert new line above" })

vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "move down in buffer with cursor centered" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "move up in buffer with cursor centered" })

vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result cursor centered" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result cursor centered" })

vim.keymap.set("n", "<leader>re", "<cmd>restart<cr>", { desc = "Restart config :restart)" })
