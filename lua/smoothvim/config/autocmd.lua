-- Autocommands
vim.api.nvim_create_augroup("custom_buffer", { clear = true })
-- highlight yanks
vim.api.nvim_create_autocmd("TextYankPost", {
  group = "custom_buffer",
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({ timeout = 200 })
  end,
})

vim.cmd([[
    augroup jdtls_lsp
        autocmd!
        autocmd FileType java lua require'smoothvim.config.jdtls'.setup_jdtls()
    augroup end
]])
