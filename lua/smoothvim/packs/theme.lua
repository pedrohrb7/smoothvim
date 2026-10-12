local cursor_accent = "#ff004f"

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

local function apply_overrides()
  for _, group in ipairs(bg_groups) do
    local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = group, link = false })
    if ok then
      hl.bg = nil
      hl.ctermbg = nil
      vim.api.nvim_set_hl(0, group, hl --[[@as vim.api.keyset.highlight]])
    end
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
local default_colorscheme = "default"

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
