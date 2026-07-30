vim.pack.add({
  { src = "https://github.com/sindrets/diffview.nvim" },
  { src = "https://github.com/lewis6991/gitsigns.nvim" },
  { src = "https://github.com/tpope/vim-fugitive" },
})

require("gitsigns").setup({
  signs = {
    add = { text = "+" },
    change = { text = "§" },
    delete = { text = "\u{2590}" }, -- ◦
    changedelete = { text = "\u{25cf}" }, -- ●
    topdelete = { text = "\u{25e6}" }, -- ◦
    untracked = { text = "┆" },
    -- delete = { text = "_" },
    -- topdelete = { text = "‾" },
    -- changedelete = { text = "~" },
    -- untracked = { text = "\u{25cb}" }, -- ○
  },
  watch_gitdir = {
    follow_files = true,
  },
  signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
  numhl = true, -- Toggle with `:Gitsigns toggle_numhl`
  linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
  word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
  current_line_blame = true,
})

local keymap = vim.keymap
local opts = { noremap = true, silent = true }

keymap.set("n", "]h", ":Gitsigns next_hunk<CR>", opts) -- "GitSigns Next Hunk" })
keymap.set("n", "[h", ":Gitsigns prev_hunk<CR>", opts) -- "GitSigns Prev Hunk" })

keymap.set({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>", opts) -- "GitSigns Stage hunk in NORMAL/VISUAL mode" })
keymap.set({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>", opts) -- "GitSigns reset hunk in NORMAL/VISUAL mode" })

keymap.set("n", "<leader>hS", "<cmd>Gitsigns stage_buffer<CR>", opts) -- "GitSigns Stage Buffer" })
keymap.set("n", "<leader>hR", "<cmd>Gitsigns reset_buffer<CR>", opts) -- "GitSigns RESET Buffer" })

keymap.set("n", "<leader>hd", '<cmd>lua require"gitsigns".diffthis("~")<CR>', opts) -- "GitSigns VDiffThis " })
keymap.set("n", "<leader>hu", "<cmd>Gitsigns undo_stage_hunk<CR>", opts) -- "GitSigns Undo Stage Hunk" })
keymap.set("n", "<leader>hb", '<cmd>lua require"gitsigns".blame_line{full=true}<CR>', opts) -- "GitSigns Blame Full" })
keymap.set("n", "<leader>hp", "<cmd>Gitsigns preview_hunk<CR>", opts) -- "GitSigns Show Hunk Preview" })
keymap.set("n", "<leader>td", "<cmd>Gitsigns toggle_deleted<CR>", opts) -- "GitSigns Toggle Deleted" })
keymap.set("n", "<leader>hB", "<cmd>Gitsigns toggle_current_line_blame<CR>", opts)

-- "O que eu editei" — status do repo do ARQUIVO atual (fugitive é buffer-aware)
keymap.set("n", "<leader>gs", "<cmd>Git<CR>", { desc = "Git status (repo do arquivo atual)" })

keymap.set("n", "<leader>gD", function()
  local root = vim.fs.root(0, ".git")
  if root then
    vim.cmd("DiffviewOpen -C" .. vim.fn.fnameescape(root))
  else
    vim.notify("Sem repositório git para este arquivo", vim.log.levels.WARN)
  end
end, { desc = "Diffview do repo do arquivo atual" })
