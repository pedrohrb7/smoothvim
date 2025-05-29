-- Here is the core config, nvim/vim config
-- This config does not relates to any plugin config
vim.cmd("let g:netrw_liststyle = 3")

local opt = vim.opt

opt.relativenumber = true
opt.number = true

-- tabs & indentation
opt.tabstop = 2 -- 2 spaces for tabs (prettier default)
opt.shiftwidth = 2 -- 2 spaces for indent width
opt.expandtab = true -- expand tab to spaces
opt.autoindent = true -- copy indent from current line when starting new one

opt.wrap = false

-- search settings
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive
opt.smartindent = true

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

-- split windows
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom

-- Cursor config
opt.guicursor = ""
  .. "n-v-c-sm:ver25-lCursor/lCursor," -- Normal
  .. "i-ci-ve:ver25-lCursor/lCursor," -- Insert
  .. "r-cr-o:hor20-vCursor/vCursor," -- Replace
  .. "a:blinkon100-blinkoff100" -- Blink

-- turn off swapfile
opt.swapfile = false
