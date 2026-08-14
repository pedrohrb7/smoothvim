-- Patch on top of the builtin "quiet" colorscheme instead of writing a full
-- theme from scratch: quiet's own base groups are fine, only a couple of
-- surfaces need fixing (see comments below).
local function patch_quiet()
  -- quiet's own dark ColorColumn shade, reused here so popups/floats stay
  -- inside the theme's existing monochrome palette instead of a new color.
  local dark_float = "#1c1c1c"

  -- Make the main editor surfaces transparent (let the terminal bg show through).
  vim.api.nvim_set_hl(0, "Normal", { fg = "#dadada", bg = "NONE" })
  vim.api.nvim_set_hl(0, "NormalNC", { fg = "#dadada", bg = "NONE" })
  vim.api.nvim_set_hl(0, "EndOfBuffer", { fg = "#707070", bg = "NONE" })
  vim.api.nvim_set_hl(0, "SignColumn", { fg = "#dadada", bg = "NONE" })
  vim.api.nvim_set_hl(0, "FoldColumn", { fg = "#707070", bg = "NONE" })
  vim.api.nvim_set_hl(0, "VertSplit", { fg = "#707070", bg = "NONE" })
  vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#707070", bg = "NONE" })

  -- quiet leaves NormalFloat/Pmenu at a bright #a8a8a8 gray, which is jarring
  -- against the near-black Normal bg. Keep floats/popups dark instead.
  vim.api.nvim_set_hl(0, "NormalFloat", { fg = "#dadada", bg = dark_float })
  vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#707070", bg = dark_float })
  vim.api.nvim_set_hl(0, "Pmenu", { fg = "#dadada", bg = dark_float })
  vim.api.nvim_set_hl(0, "PmenuExtra", { fg = "#dadada", bg = dark_float })
  vim.api.nvim_set_hl(0, "PmenuKind", { fg = "#dadada", bg = dark_float, bold = true })
  vim.api.nvim_set_hl(0, "PmenuSbar", { bg = dark_float })

  -- quiet's StatusLine is `reverse` on #dadada, i.e. a bright gray bar across
  -- the whole width (laststatus=3). Drop the reverse/bg so it's transparent
  -- and the custom StlMode/StlGit groups from statusline.lua stand out.
  vim.api.nvim_set_hl(0, "StatusLine", { fg = "#dadada", bg = "NONE" })
  vim.api.nvim_set_hl(0, "StatusLineNC", { fg = "#707070", bg = "NONE" })
end

vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "quiet",
  callback = patch_quiet,
})

vim.cmd.colorscheme("quiet")
