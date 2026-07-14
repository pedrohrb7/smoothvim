local function augroup(name)
  return vim.api.nvim_create_augroup("user_" .. name, { clear = true })
end

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("highlight_yank"),
  callback = function()
    (vim.hl or vim.highlight).on_yank()
  end,
})

-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  group = augroup("checktime"),
  callback = function()
    if vim.o.buftype ~= "nofile" then
      vim.cmd("checktime")
    end
  end,
})

-- wrap and check for spell in text filetypes
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("wrap_spell"),
  pattern = { "text", "plaintex", "typst", "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
    vim.opt_local.linebreak = true
  end,
})

-- Auto create dir when saving a file, in case some intermediate directory does not exist
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  group = augroup("auto_create_dir"),
  callback = function(event)
    if event.match:match("^%w%w+:[\\/][\\/]") then
      return
    end
    local file = vim.uv.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})

-- Set filetype for .env and .env.* files
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  group = augroup("env_filetype"),
  pattern = { "*.env", ".env.*" },
  callback = function()
    vim.opt_local.filetype = "sh"
  end,
})

-- Set filetype for .toml files
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  group = augroup("toml_filetype"),
  pattern = { "*.tomg-config*" },
  callback = function()
    vim.opt_local.filetype = "toml"
  end,
})

-- Set filetype for .ejs files
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  group = augroup("ejs_filetype"),
  pattern = { "*.ejs", "*.ejs.t" },
  callback = function()
    vim.opt_local.filetype = "embedded_template"
  end,
})

local augroup_format = vim.api.nvim_create_augroup("autocmd_format_file", { clear = true })
-- Format on save (ONLY real file buffers, ONLY when efm is attached)
vim.api.nvim_create_autocmd("BufWritePre", {
  group = augroup_format,
  pattern = {
    "*.lua",
    "*.py",
    "*.go",
    "*.js",
    "*.jsx",
    "*.ts",
    "*.tsx",
    "*.json",
    "*.css",
    "*.scss",
    "*.html",
    "*.sh",
    "*.bash",
    "*.zsh",
    "*.c",
    "*.cpp",
    "*.h",
    "*.hpp",
  },
  callback = function(args)
    -- avoid formatting non-file buffers (helps prevent weird write prompts)
    if vim.bo[args.buf].buftype ~= "" then
      return
    end
    if not vim.bo[args.buf].modifiable then
      return
    end
    if vim.api.nvim_buf_get_name(args.buf) == "" then
      return
    end

    local has_efm = false
    for _, c in ipairs(vim.lsp.get_clients({ bufnr = args.buf })) do
      if c.name == "efm" then
        has_efm = true
        break
      end
    end
    if not has_efm then
      return
    end

    pcall(vim.lsp.buf.format, {
      bufnr = args.buf,
      timeout_ms = 2000,
      filter = function(c)
        return c.name == "efm"
      end,
    })
  end,
})
