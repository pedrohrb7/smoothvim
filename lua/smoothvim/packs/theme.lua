-- Patch on top of the builtin "quiet" colorscheme instead of writing a full
local function patch_quiet()
  local dark_float = "#1c1c1c"
  local base_accent = "#ff004f"

  vim.api.nvim_set_hl(0, "Cursor", { fg = "#000000", bg = base_accent })
  vim.api.nvim_set_hl(0, "Visual", { fg = "#000000", bg = base_accent })

  vim.api.nvim_set_hl(0, "Normal", { fg = "#dadada", bg = "NONE" })
  vim.api.nvim_set_hl(0, "NormalNC", { fg = "#dadada", bg = "NONE" })
  vim.api.nvim_set_hl(0, "EndOfBuffer", { fg = "#707070", bg = "NONE" })
  vim.api.nvim_set_hl(0, "SignColumn", { fg = "#dadada", bg = "NONE" })
  vim.api.nvim_set_hl(0, "FoldColumn", { fg = "#707070", bg = "NONE" })
  vim.api.nvim_set_hl(0, "VertSplit", { fg = "#707070", bg = "NONE" })
  vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#707070", bg = "NONE" })

  vim.api.nvim_set_hl(0, "NormalFloat", { fg = "#dadada", bg = dark_float })
  vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#707070", bg = dark_float })
  vim.api.nvim_set_hl(0, "Pmenu", { fg = "#dadada", bg = dark_float })
  vim.api.nvim_set_hl(0, "PmenuExtra", { fg = "#dadada", bg = dark_float })
  vim.api.nvim_set_hl(0, "PmenuKind", { fg = "#dadada", bg = dark_float, bold = true })
  vim.api.nvim_set_hl(0, "PmenuSbar", { bg = dark_float })

  vim.api.nvim_set_hl(0, "StatusLine", { fg = "#dadada", bg = "NONE" })
  vim.api.nvim_set_hl(0, "StatusLineNC", { fg = "#707070", bg = "NONE" })
end

vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "quiet",
  callback = patch_quiet,
})

vim.cmd.colorscheme("quiet")

-- Neovim's default 'guicursor' never attaches the Cursor/lCursor highlight
-- group to the n/v/i/r/o modes (only "t:...-TermCursor" references a group),
-- so `hi Cursor ...` alone is inert and the terminal just shows its own
-- default cursor color. Re-declare guicursor with -Cursor/lCursor appended
-- to each mode so the highlight above actually takes effect.
vim.opt.guicursor =
  "n-v-c-sm:block-Cursor/lCursor,i-ci-ve:ver25-Cursor/lCursor,r-cr-o:hor20-Cursor/lCursor,t:block-blinkon500-blinkoff500-TermCursor"
