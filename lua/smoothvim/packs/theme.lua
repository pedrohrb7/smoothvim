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

apply_overrides()

vim.opt.guicursor =
  "n-v-c-sm:block-Cursor/lCursor,i-ci-ve:ver25-Cursor/lCursor,r-cr-o:hor20-Cursor/lCursor,t:block-blinkon500-blinkoff500-TermCursor"
