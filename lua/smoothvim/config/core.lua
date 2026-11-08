-- Here is the core config, nvim/vim config
-- This config does not relates to any plugin config
vim.cmd("let g:netrw_liststyle = 3")
vim.g.netrw_keepdir = 0
-- vim.g.netrw_banner = 0
-- vim.g.netrw_winsize = 25
vim.cmd("set completeopt+=noselect")

vim.g.markdown_recommended_style = 0
vim.g.autoformat = true
vim.g.trouble_lualine = true

local opt = vim.opt

opt.relativenumber = true
opt.number = true

-- tabs & indentation
opt.tabstop = 2 -- 2 spaces for tabs (prettier default)
opt.shiftwidth = 2 -- 2 spaces for indent width
opt.expandtab = true -- expand tab to spaces
opt.autoindent = true -- copy indent from current line when starting new one
opt.winborder = "rounded"

opt.wrap = false

-- search settings
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive
opt.smartindent = true
opt.inccommand = "split"
opt.laststatus = 3
vim.opt.scrolloff = 8

opt.cursorline = true
opt.cursorcolumn = true
opt.fileencoding = "utf-8"

opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

-- backspace
opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position

-- clipboard
opt.clipboard:append("unnamedplus") -- use system clipboard as default register

-- Over SSH, xclip/wl-copy would hit the remote machine's clipboard (or none).
-- Copy through OSC 52 instead, so yanks reach the local terminal's clipboard.
-- Paste reads the local unnamed register: OSC 52 reads are slow and kitty asks
-- for confirmation on each one. Paste host content with the terminal (Ctrl+Shift+V).
if vim.env.SSH_TTY then
  local osc52 = require("vim.ui.clipboard.osc52")
  local function paste()
    return { vim.fn.split(vim.fn.getreg(""), "\n"), vim.fn.getregtype("") }
  end
  vim.g.clipboard = {
    name = "OSC 52",
    copy = { ["+"] = osc52.copy("+"), ["*"] = osc52.copy("*") },
    paste = { ["+"] = paste, ["*"] = paste },
  }
end

-- split windows
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom

-- turn off swapfile
opt.swapfile = false

-- Folding: requires treesitter available at runtime; safe fallback if not
vim.opt.foldmethod = "expr" -- use expression for folding
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()" -- use treesitter for folding
vim.opt.foldlevel = 99 -- start with all folds open

-- .env files must not be "sh": that attaches bashls/shellcheck, which flags
-- every variable as unused (SC2034).
vim.filetype.add({
  extension = {
    env = "dotenv",
  },
  filename = {
    [".env"] = "dotenv",
    ["env"] = "dotenv",
  },
  pattern = {
    ["[jt]sconfig.*.json"] = "jsonc",
    ["%.env%.[%w_.-]+"] = "dotenv",
  },
})
