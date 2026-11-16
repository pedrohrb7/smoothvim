-- claudinho.nvim (fork local do claudecode.nvim), carregado direto do repo de
-- desenvolvimento em vez de vim.pack: qualquer edição no repo vale ao reabrir o
-- Neovim, sem commit nem update. O módulo Lua ainda se chama "claudecode".
local claudinho_dir = vim.fn.expand("~/workspaces/claudinho.nvim")

if vim.fn.isdirectory(claudinho_dir) == 0 then
  vim.notify("claudinho.nvim não encontrado em " .. claudinho_dir, vim.log.levels.WARN)
 return
end

vim.opt.runtimepath:prepend(claudinho_dir)

require("claudinho").setup({
  split_side = "left",
  log_level = "info", -- troque para "debug" ao investigar
})

local keymap = vim.keymap

keymap.set("n", "<leader>ac", "<cmd>ClaudeCode<cr>", { desc = "Claude: toggle" })
keymap.set("n", "<leader>af", "<cmd>ClaudeCodeFocus<cr>", { desc = "Claude: focus" })
keymap.set("n", "<leader>ar", "<cmd>ClaudeCode --resume<cr>", { desc = "Claude: resume" })
keymap.set("n", "<leader>aC", "<cmd>ClaudeCode --continue<cr>", { desc = "Claude: continue" })
keymap.set("n", "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", { desc = "Claude: select model" })
keymap.set("n", "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", { desc = "Claude: add current buffer" })
keymap.set("v", "<leader>as", "<cmd>ClaudeCodeSend<cr>", { desc = "Claude: send selection" })
keymap.set("n", "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", { desc = "Claude: accept diff" })
keymap.set("n", "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", { desc = "Claude: deny diff" })

-- No neo-tree/netrw/oil: <leader>as adiciona o arquivo sob o cursor
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("ClaudinhoTreeAdd", { clear = true }),
  pattern = { "neo-tree", "netrw", "oil", "NvimTree", "minifiles" },
  callback = function(ev)
    keymap.set("n", "<leader>as", "<cmd>ClaudeCodeTreeAdd<cr>", { buffer = ev.buf, desc = "Claude: add file" })
  end,
})
