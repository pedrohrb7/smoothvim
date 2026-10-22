vim.pack.add({
  { src = "https://github.com/folke/tokyonight.nvim" },
  { src = "https://github.com/daltonmenezes/aura-theme" },
  { src = "https://github.com/xero/evangelion.nvim" },
  { src = "https://github.com/xero/miasma.nvim" },
  { src = "https://github.com/xero/sourcerer.vim" },
  { src = "https://github.com/morhetz/gruvbox" },
})

-- aura-theme is a monorepo; the Neovim port lives in a subdirectory.
local aura = vim.pack.get({ "aura-theme" })[1]
if aura then
  vim.opt.runtimepath:append(aura.path .. "/packages/neovim")
end

local cursor_accent = "#ff004f"

-- The hand-written theme: "default" plus the overrides below. Only this one is
-- transparent; every other colorscheme keeps its own backgrounds.
local default_colorscheme = "default"

local bg_groups = {
  "Normal",
  "NormalNC",
  "SignColumn",
  "EndOfBuffer",
  "FoldColumn",
  "LineNr",
  "CursorLineNr",
  "StatusLine",
  "StatusLineNC",
  "TabLine",
  "TabLineFill",
  "TabLineSel",
  "VertSplit",
  "WinSeparator",
}

local function clear_backgrounds()
  for _, group in ipairs(bg_groups) do
    local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = group, link = false })
    if ok then
      hl.bg = nil
      hl.ctermbg = nil
      vim.api.nvim_set_hl(0, group, hl --[[@as vim.api.keyset.highlight]])
    end
  end
end

local function apply_overrides()
  if vim.g.colors_name == default_colorscheme then
    clear_backgrounds()
  end

  vim.api.nvim_set_hl(0, "Cursor", { fg = "#000000", bg = cursor_accent })
end

vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = apply_overrides,
})

-- Persist the last applied colorscheme outside the repo, so switching themes
-- (e.g. via Telescope colorscheme) doesn't require a code change/commit.
local colorscheme_file = vim.fn.stdpath("state") .. "/colorscheme"

local function read_saved_colorscheme()
  local f = io.open(colorscheme_file, "r")
  if not f then
    return nil
  end
  local name = vim.trim(f:read("*a") or "")
  f:close()
  return name ~= "" and name or nil
end

local function save_colorscheme(name)
  if not name or name == read_saved_colorscheme() then
    return
  end
  vim.fn.mkdir(vim.fn.fnamemodify(colorscheme_file, ":h"), "p")
  local f = io.open(colorscheme_file, "w")
  if f then
    f:write(name)
    f:close()
  end
end

local saved = read_saved_colorscheme()
if not (saved and pcall(vim.cmd.colorscheme, saved)) then
  pcall(vim.cmd.colorscheme, default_colorscheme)
end

-- Registered after the initial load. Telescope previews also fire ColorScheme,
-- but cancelling the picker restores the original theme, so the last write wins.
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function(args)
    save_colorscheme(args.match)
  end,
})

apply_overrides()

vim.opt.guicursor =
  "n-v-c-sm:block-Cursor/lCursor,i-ci-ve:ver25-Cursor/lCursor,r-cr-o:hor20-Cursor/lCursor,t:block-blinkon500-blinkoff500-TermCursor"
