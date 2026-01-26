vim.cmd("hi clear")
vim.g.colors_name = "cybersmooth"

local colors = {
  bg = "#000b1e",
  fg = "#0abdc6",
  red = "#f38ba8",
  dark_red = "#bf616a",
  green = "#a6e3a1",
  dark_green = "#a3be8c",
  blue = "#91d7fb",
  cyan = "#89dceb",
  aqua = "#00ffff",
  yellow = "#fab387",
  white = "#d8dee9",
  magenta = "#cba6f7",
  fuchsia = "#ff00ff",
  accent = "#d300c4",
  disabled = "#888888",
}

-- Basic UI groups
vim.api.nvim_set_hl(0, "Normal", { fg = colors.white, bg = colors.bg })
vim.api.nvim_set_hl(0, "Comment", { fg = colors.green, italic = true })

vim.api.nvim_set_hl(0, "Visual", { bg = colors.magenta, fg = colors.bg }) -- Text selection
vim.api.nvim_set_hl(0, "Search", { fg = colors.yellow, bg = colors.bg })
vim.api.nvim_set_hl(0, "LineNr", { fg = colors.fg, bg = colors.bg }) -- Line numbers
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = colors.yellow, bold = true })

-- Telescope specific groups
vim.api.nvim_set_hl(0, "TelescopeSelection", { bg = colors.magenta, fg = colors.bg, bold = true })

vim.api.nvim_set_hl(0, "TelescopeBorder", { fg = colors.fg, bg = colors.accent }) -- Color for Telescope border
vim.api.nvim_set_hl(0, "TelescopePromptBorder", { fg = colors.accent })
vim.api.nvim_set_hl(0, "TelescopeResultsBorder", { fg = colors.accent }) -- Border around the results window
vim.api.nvim_set_hl(0, "TelescopePreviewBorder", { fg = colors.accent }) -- Border around the preview window

vim.api.nvim_set_hl(0, "TelescopePromptNormal", { fg = colors.fg }) -- Normal text in the prompt
vim.api.nvim_set_hl(0, "TelescopePromptTitle", { fg = colors.magenta, bold = true }) -- Title of the prompt window
vim.api.nvim_set_hl(0, "TelescopeResultsTitle", { fg = colors.dark_green, bold = true }) -- Title in the results window
vim.api.nvim_set_hl(0, "TelescopePreviewTitle", { fg = colors.dark_red, bold = true }) -- Title in the preview window

vim.api.nvim_set_hl(0, "TelescopeSelectionCaret", { fg = colors.yellow }) -- Icon or caret for selected item
vim.api.nvim_set_hl(0, "TelescopeMatching", { fg = colors.white, bold = true }) -- Highlight matches in the search results

vim.api.nvim_set_hl(0, "TelescopeResultsNormal", { bg = colors.bg }) -- Normal text in the results window
vim.api.nvim_set_hl(0, "TelescopePreviewNormal", { bg = colors.bg }) -- Normal text in the preview window

-- Syntax groups
vim.api.nvim_set_hl(0, "String", { fg = colors.yellow }) -- Strings
vim.api.nvim_set_hl(0, "Function", { fg = colors.dark_red, bold = true }) -- Function names
vim.api.nvim_set_hl(0, "Keyword", { fg = colors.fuchsia, italic = true }) -- Keywords
vim.api.nvim_set_hl(0, "Constant", { fg = colors.dark_red }) -- Constants
vim.api.nvim_set_hl(0, "Type", { fg = colors.dark_green }) -- Type annotations
vim.api.nvim_set_hl(0, "Variable", { fg = colors.dark_red }) -- Variables
vim.api.nvim_set_hl(0, "Error", { fg = colors.red, bold = true }) -- Errors

-- Diagnostics (LSP or others)
vim.api.nvim_set_hl(0, "DiagnosticError", { fg = colors.red })
vim.api.nvim_set_hl(0, "DiagnosticWarn", { fg = colors.yellow })
vim.api.nvim_set_hl(0, "DiagnosticInfo", { fg = colors.cyan })
vim.api.nvim_set_hl(0, "DiagnosticHint", { fg = colors.green })

-- Git-related groups
vim.api.nvim_set_hl(0, "GitSignsAdd", { fg = colors.green }) -- Git added
vim.api.nvim_set_hl(0, "GitSignsChange", { fg = colors.yellow }) -- Git modified
vim.api.nvim_set_hl(0, "GitSignsDelete", { fg = colors.red }) -- Git deleted

vim.api.nvim_set_hl(0, "NeoTreeGitAdded", { fg = colors.green })
vim.api.nvim_set_hl(0, "NeoTreeGitConflict", { fg = colors.red })
vim.api.nvim_set_hl(0, "NeoTreeGitModified", { fg = colors.yellow })
vim.api.nvim_set_hl(0, "NeoTreeGitDeleted", { fg = colors.red, italic = true })
vim.api.nvim_set_hl(0, "NeoTreeGitUntracked", { fg = colors.fg })
vim.api.nvim_set_hl(0, "NeoTreeGitIgnored", { fg = colors.disabled, italic = true })

-- Underline styles
vim.api.nvim_set_hl(0, "Underlined", { underline = true, fg = colors.blue })
vim.api.nvim_set_hl(0, "Bold", { bold = true })
vim.api.nvim_set_hl(0, "Italic", { italic = true })

-- Tree-sitter
vim.api.nvim_set_hl(0, "TSFunction", { fg = colors.red, bold = true })
vim.api.nvim_set_hl(0, "TSKeyword", { fg = colors.red, italic = true })
vim.api.nvim_set_hl(0, "TSVariable", { fg = colors.red })

-- Set Neo-tree highlights
vim.api.nvim_set_hl(0, "NeoTreeNormal", { bg = colors.bg, fg = colors.fg })
vim.api.nvim_set_hl(0, "NeoTreeNormalNC", { bg = colors.bg, fg = colors.fg }) -- Inactive Neo-tree
vim.api.nvim_set_hl(0, "NeoTreeCursorLine", { bg = colors.magenta, fg = colors.bg, bold = true })
vim.api.nvim_set_hl(0, "NeoTreeTitleBar", { bg = colors.blue, fg = "#000000", bold = true })
vim.api.nvim_set_hl(0, "NeoTreeRootName", { fg = colors.green, bold = true })
vim.api.nvim_set_hl(0, "NeoTreeDirectoryName", { fg = colors.blue, bold = true })
vim.api.nvim_set_hl(0, "NeoTreeDirectoryIcon", { fg = colors.yellow })
vim.api.nvim_set_hl(0, "NeoTreeFileName", { fg = colors.white })
vim.api.nvim_set_hl(0, "NeoTreeFileNameOpened", { fg = colors.green, italic = true })
vim.api.nvim_set_hl(0, "NeoTreeIndentMarker", { fg = colors.bg }) -- Indentation visual
vim.api.nvim_set_hl(0, "NeoTreeSymbolicLinkTarget", { fg = colors.purple, underline = true })

-- Diagnostics highlights
vim.api.nvim_set_hl(0, "NeoTreeDiagnosticError", { fg = colors.red, bold = true })
vim.api.nvim_set_hl(0, "NeoTreeDiagnosticWarn", { fg = colors.yellow, bold = true })
vim.api.nvim_set_hl(0, "NeoTreeDiagnosticInfo", { fg = colors.blue })
vim.api.nvim_set_hl(0, "NeoTreeDiagnosticHint", { fg = colors.green })
