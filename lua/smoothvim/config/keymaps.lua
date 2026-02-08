-- Same as core_config but keymaps
-- Keymaps that does not exec any plugin
vim.g.mapleader = "\\"
vim.g.maplocalleader = "\\"

-- Keymaps that exec plugins

local keymap = vim.keymap -- for conciseness
local opts = { noremap = true, silent = true }

keymap.set("i", "jk", "<ESC>", opts, { desc = "Exit insert mode with hl" })
-- Exit Vim's terminal mode
keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
keymap.set("n", "<leader>nh", ":nohl<CR>", opts, { desc = "Clear search highlights" })

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", opts, { desc = "Increment number" }) -- increment
keymap.set("n", "<leader>-", "<C-x>", opts, { desc = "Decrement number" }) -- decrement

keymap.set("n", "<C-s>", "<cmd>:update<CR>", opts, { desc = "Update file changes" })
keymap.set("n", "<C-q>", "<cmd>:q<CR>", opts, { desc = "Quit nvim" })

--  buffer navigation
keymap.set("n", "<S-l>", ":bnext<CR>", opts, { desc = "better way to navigate to next buffer" })
keymap.set("n", "<S-h>", ":bprev<CR>", opts, { desc = "better way to navigate to previous buffer" })

-- Easily split windows
vim.keymap.set("n", "<leader>wv", ":vsplit<cr>", { desc = "[W]indow Split [V]ertical" })
vim.keymap.set("n", "<leader>wh", ":split<cr>", { desc = "[W]indow Split [H]orizontal" })

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

-- ##############################################################

--Neo-tree plugin
keymap.set("n", "<leader>ne", ":Neotree toggle<CR>", opts, { desc = "Toggle file explorer" }) -- toggle file explorer
keymap.set("n", "<C-t>", ":Neotree toggle<CR>", opts, { desc = "Alternative map to toggle file explorer" }) -- toggle file explorer
keymap.set("n", "<leader>nb", ":Neotree buffers reveal float<CR>", opts, { desc = "Reveal buffers in modal" })
keymap.set("n", "--", ":Neotree reveal<CR>", opts, { desc = "Reveal file under cursos" })

-- Lint
keymap.set("n", "<leader>ll", function()
  require("lint").try_lint()
end, { desc = "Trigger linting in current buffer" })

-- Telescope plugin
keymap.set("n", "<leader>tf", "<cmd>Telescop find_files<CR>", opts, { desc = "Telescope Find file" })
keymap.set("n", "<leader>tg", "<cmd>Telescop live_grep<CR>", { desc = "Telescope Search by word" })
keymap.set("n", "<leader>tb", "<cmd>Telescop buffers<CR>", { desc = "Search in open buffers" })

-- Trouble plugin
keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", opts, { desc = "Diagnostics (Trouble)" })
keymap.set(
  "n",
  "<leader>xX",
  "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
  opts,
  { desc = "Buffer Diagnostics (Trouble)" }
)

-- Conform Plugin (formatting.lua)
keymap.set("n", "<leader>mp", function()
  local conform = require("conform")
  conform.format({
    lsp_fallback = true,
    async = false,
    timeout_ms = 500,
  })
end, { desc = "Conform Format file or range" })

-- LSP
keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Show LSP definitions" }) -- show lsp definitions

keymap.set("n", "gR", vim.lsp.buf.references, { desc = "Show LSP references" }) -- show definition, references

keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Smart rename" }) -- smart rename

keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "See available code actions" }) -- see available code actions, in visual mode will apply to selection

keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" }) -- go to declaration

keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "Show LSP implementations" }) -- show lsp implementations

keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", { desc = "Show LSP type definitions" }) -- show lsp type definitions

keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", { desc = "Show buffer diagnostics" }) -- show  diagnostics for file

keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Show line diagnostics" }) -- show diagnostics for line

keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" }) -- jump to previous diagnostic in buffer

keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" }) -- jump to next diagnostic in buffer

keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Show documentation for what is under cursor" }) -- show documentation for what is under cursor

-- keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, { desc = "Show signature help for what is under cursor" })

-- End LSP

-- LSP Signature Help Plugin
keymap.set("n", "<leader>k", function()
  vim.lsp.buf.signature_help()
end, opts, { desc = "toggle signature" })

-- GitSigns Plugin
keymap.set("n", "]h", ":Gitsigns next_hunk<CR>", opts, { desc = "GitSigns Next Hunk" })
keymap.set("n", "[h", ":Gitsigns prev_hunk<CR>", opts, { desc = "GitSigns Prev Hunk" })

keymap.set("n", "<leader>hs", ":Gitsigns stage_hunk<CR>", opts, { desc = "GitSigns Stage hunk in NORMAL mode" })
keymap.set("v", "<leader>hs", ":Gitsigns stage_hunk<CR>", opts, { desc = "GitSigns Stage hunk in VISUAL mode" })

keymap.set("n", "<leader>hr", ":Gitsigns reset_hunk<CR>", opts, { desc = "GitSigns reset hunk in NORMAL mode" })
keymap.set("v", "<leader>hr", ":Gitsigns reset_hunk<CR>", opts, { desc = "GitSigns reset hunk in VISUAL mode" })

keymap.set("n", "<leader>hS", "<cmd>Gitsigns stage_buffer<CR>", opts, { desc = "GitSigns Stage Buffer" })
keymap.set("n", "<leader>hR", "<cmd>Gitsigns reset_buffer<CR>", opts, { desc = "GitSigns RESET Buffer" })

keymap.set("n", "<leader>hd", '<cmd>lua require"gitsigns".diffthis("~")<CR>', opts, { desc = "GitSigns VDiffThis " })
keymap.set("n", "<leader>hu", "<cmd>Gitsigns undo_stage_hunk<CR>", opts, { desc = "GitSigns Undo Stage Hunk" })
keymap.set(
  "n",
  "<leader>hb",
  '<cmd>lua require"gitsigns".blame_line{full=true}<CR>',
  opts,
  { desc = "GitSigns Blame Full" }
)
keymap.set("n", "<leader>hp", "<cmd>Gitsigns preview_hunk<CR>", opts, { desc = "GitSigns Show Hunk Preview" })
keymap.set("n", "<leader>td", "<cmd>Gitsigns toggle_deleted<CR>", opts, { desc = "GitSigns Toggle Deleted" })
-- End GitSigns Plugin
