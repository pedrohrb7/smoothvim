local keymap = vim.keymap -- for conciseness

keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with hl" })

-- Exit Vim's terminal mode
keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

keymap.set("n", "<C-s>", "<cmd>:update<CR>", { desc = "Update file changes" })
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
keymap.set("v", "p", '"_dP', { desc = "Keep last yanked when pasting" })

-- insert new line
keymap.set("n", "<leader>o", "o<ESC>", { desc = "insert new line below" })
keymap.set("n", "<leader>O", "O<ESC>", { desc = "insert new line above" })

-- ##############################################################

--Neo-tree plugin
keymap.set("n", "<leader>ne", ":Neotree toggle<CR>", { desc = "Toggle file explorer" }) -- toggle file explorer
keymap.set("n", "<C-t>", ":Neotree toggle<CR>", { desc = "Alternative map to toggle file explorer" }) -- toggle file explorer
keymap.set("n", "<leader>qw", ":Neotree buffers reveal float<CR>", { desc = "Reveal buffers in modal" })
keymap.set("n", "--", ":Neotree reveal<CR>", { desc = "Reveal file under cursos" })

-- Lint
keymap.set("n", "<leader>ll", function()
  require("lint").try_lint()
end, { desc = "Trigger linting in current buffer" })

-- Trouble plugin
keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics (Trouble)" })
keymap.set(
  "n",
  "<leader>xX",
  "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
  { desc = "Buffer Diagnostics (Trouble)" }
)

-- Conform Plugin (formatting.lua)
keymap.set("n", "<leader>ft", function()
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
end, { desc = "toggle signature" })

-- GitSigns Plugin
keymap.set("n", "]h", ":Gitsigns next_hunk<CR>", { desc = "GitSigns Next Hunk" })
keymap.set("n", "[h", ":Gitsigns prev_hunk<CR>", { desc = "GitSigns Prev Hunk" })

keymap.set("n", "<leader>hs", ":Gitsigns stage_hunk<CR>", { desc = "GitSigns Stage hunk in NORMAL mode" })
keymap.set("v", "<leader>hs", ":Gitsigns stage_hunk<CR>", { desc = "GitSigns Stage hunk in VISUAL mode" })

keymap.set("n", "<leader>hr", ":Gitsigns reset_hunk<CR>", { desc = "GitSigns reset hunk in NORMAL mode" })
keymap.set("v", "<leader>hr", ":Gitsigns reset_hunk<CR>", { desc = "GitSigns reset hunk in VISUAL mode" })

keymap.set("n", "<leader>hS", "<cmd>Gitsigns stage_buffer<CR>", { desc = "GitSigns Stage Buffer" })
keymap.set("n", "<leader>hR", "<cmd>Gitsigns reset_buffer<CR>", { desc = "GitSigns RESET Buffer" })

keymap.set("n", "<leader>hd", '<cmd>lua require"gitsigns".diffthis("~")<CR>', { desc = "GitSigns VDiffThis " })
keymap.set("n", "<leader>hu", "<cmd>Gitsigns undo_stage_hunk<CR>", { desc = "GitSigns Undo Stage Hunk" })
keymap.set("n", "<leader>hb", '<cmd>lua require"gitsigns".blame_line{full=true}<CR>', { desc = "GitSigns Blame Full" })
keymap.set("n", "<leader>hp", "<cmd>Gitsigns preview_hunk<CR>", { desc = "GitSigns Show Hunk Preview" })
keymap.set("n", "<leader>td", "<cmd>Gitsigns toggle_deleted<CR>", { desc = "GitSigns Toggle Deleted" })
-- End GitSigns Plugin
