vim.pack.add({
 { src = "https://github.com/sindrets/diffview.nvim" },
  { src = "https://github.com/lewis6991/gitsigns.nvim" },
})

require("gitsigns").setup({
  signs = {
    add = { text = "+" },
    change = { text = "§" },
    delete = { text = "_" },
    topdelete = { text = "‾" },
    changedelete = { text = "~" },
    untracked = { text = "┆" },
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

keymap.set("n", "<leader>hs", ":Gitsigns stage_hunk<CR>", opts) -- "GitSigns Stage hunk in NORMAL mode" })
keymap.set("v", "<leader>hs", ":Gitsigns stage_hunk<CR>", opts) -- "GitSigns Stage hunk in VISUAL mode" })

keymap.set("n", "<leader>hr", ":Gitsigns reset_hunk<CR>", opts) -- "GitSigns reset hunk in NORMAL mode" })
keymap.set("v", "<leader>hr", ":Gitsigns reset_hunk<CR>", opts) -- "GitSigns reset hunk in VISUAL mode" })

keymap.set("n", "<leader>hS", "<cmd>Gitsigns stage_buffer<CR>", opts) -- "GitSigns Stage Buffer" })
keymap.set("n", "<leader>hR", "<cmd>Gitsigns reset_buffer<CR>", opts) -- "GitSigns RESET Buffer" })

keymap.set("n", "<leader>hd", '<cmd>lua require"gitsigns".diffthis("~")<CR>', opts) -- "GitSigns VDiffThis " })
keymap.set("n", "<leader>hu", "<cmd>Gitsigns undo_stage_hunk<CR>", opts) -- "GitSigns Undo Stage Hunk" })
keymap.set("n", "<leader>hb", '<cmd>lua require"gitsigns".blame_line{full=true}<CR>', opts) -- "GitSigns Blame Full" })
keymap.set("n", "<leader>hp", "<cmd>Gitsigns preview_hunk<CR>", opts) -- "GitSigns Show Hunk Preview" })
keymap.set("n", "<leader>td", "<cmd>Gitsigns toggle_deleted<CR>", opts) -- "GitSigns Toggle Deleted" })
