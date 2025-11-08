-- Keymaps that exec plugins

local keymap = vim.keymap -- for conciseness
local opts = { noremap = true, silent = true }

--Neo-tree plugin
keymap.set("n", "<leader>ne", ":Neotree toggle<CR>", opts, { desc = "Toggle file explorer" }) -- toggle file explorer
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

-- JDTLS
keymap.set("n", "<leader>co", "<Cmd>lua require'jdtls'.organize_imports()<CR>", { desc = "Organize Imports" })
keymap.set("n", "<leader>crv", "<Cmd>lua require('jdtls').extract_variable()<CR>", { desc = "Extract Variable" })
keymap.set(
  "v",
  "<leader>crv",
  "<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>",
  { desc = "Extract Variable" }
)
keymap.set("n", "<leader>crc", "<Cmd>lua require('jdtls').extract_constant()<CR>", { desc = "Extract Constant" })
keymap.set(
  "v",
  "<leader>crc",
  "<Esc><Cmd>lua require('jdtls').extract_constant(true)<CR>",
  { desc = "Extract Constant" }
)
keymap.set("v", "<leader>crm", "<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>", { desc = "Extract Method" })
-- End Java Keymaps

-- ToggleTerm plugin
keymap.set("n", "<leader>tt", ":ToggleTerm<CR>", { desc = "ToggleTerm on float mode" })
