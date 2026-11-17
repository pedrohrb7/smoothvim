-- claudinho.nvim (fork local do claudecode.nvim), carregado direto do repo de
-- desenvolvimento em vez de vim.pack: qualquer edição no repo vale ao reabrir o
-- Neovim, sem commit nem update. O módulo Lua ainda se chama "claudecode".
local claudinho_dir = vim.fn.expand("~/workspaces/claudinho.nvim")

if vim.fn.isdirectory(claudinho_dir) == 0 then
  vim.notify("claudinho.nvim não encontrado em " .. claudinho_dir, vim.log.levels.WARN)
  return
end

vim.opt.runtimepath:prepend(claudinho_dir)

-- Payload default do Claudinho (lua/claudinho/config.lua), explícito para facilitar ajustes.
require("claudinho").setup({
  port_range = { min = 10000, max = 65535 },
  terminal_cmd = nil, -- comando do Claude; nil usa "claude"
  env = {}, -- variáveis de ambiente extras do terminal (strings)
  log_level = "info", -- "trace" | "debug" | "info" | "warn" | "error"; use "debug" ao investigar
  track_selection = true,
  focus_after_send = false, -- foca o terminal depois de um envio aceito
  visual_demotion_delay_ms = 50,
  connection_wait_delay = 600, -- ms de espera após a conexão antes de enviar @-mentions na fila
  connection_timeout = 10000, -- ms para o Claude conectar antes de a fila falhar com erro
  diff_opts = {
    layout = "vertical", -- "vertical" | "horizontal" | "unified"
    open_in_new_tab = true,
    keep_terminal_focus = true, -- devolve o foco ao terminal quando o diff abre
    hide_terminal_in_new_tab = false, -- com open_in_new_tab, não mostra o terminal na nova aba
    on_new_file_reject = "keep_empty", -- "keep_empty" | "close_window"
    auto_resize_terminal = true, -- false = você controla a largura via ClaudinhoDiffOpened/Closed
  },
  models = {
    { name = "Claude Opus (Latest)", value = "opus" },
    { name = "Claude Opus (Latest, 1M context)", value = "opus[1m]" },
    { name = "Claude Sonnet (Latest)", value = "sonnet" },
    { name = "Claude Sonnet (Latest, 1M context)", value = "sonnet[1m]" },
    { name = "Claude Haiku (Latest)", value = "haiku" },
    { name = "Default (account recommended)", value = "default" },
  },
  window = {
    layout = "right", -- "left" | "right" | "bottom" | "float" | "tab"
    right = {
      width = 0.30, -- fração da largura do editor, em (0, 1)
      diff_width = nil, -- nil ou fração em (0, 1): largura com um diff aberto
    },
    bottom = { height = 0.30 },
    float = { width = 0.80, height = 0.80 },
    tab_title_max = 14, -- maior título de aba no winbar, em colunas
  },
  keymaps = { preset = false },
  notify = false, -- notificações informativas (erros e respostas sempre aparecem)
  terminal = {
    auto_insert = true,
    fix_streamed_paste = "auto", -- true | false | "auto"
  },
})

local keymap = vim.keymap

keymap.set("n", "<leader>ac", "<cmd>Claudinho<cr>", { desc = "Claude: toggle" })
keymap.set("n", "<leader>af", "<cmd>ClaudinhoFocus<cr>", { desc = "Claude: focus" })
keymap.set("n", "<leader>ar", "<cmd>Claudinho --resume<cr>", { desc = "Claude: resume" })
keymap.set("n", "<leader>aC", "<cmd>Claudinho --continue<cr>", { desc = "Claude: continue" })
keymap.set("n", "<leader>am", "<cmd>ClaudinhoSelectModel<cr>", { desc = "Claude: select model" })
keymap.set("n", "<leader>ab", "<cmd>ClaudinhoAdd %<cr>", { desc = "Claude: add current buffer" })
keymap.set("v", "<leader>as", "<cmd>ClaudinhoSend<cr>", { desc = "Claude: send selection" })
keymap.set("n", "<leader>aa", "<cmd>ClaudinhoDiffAccept<cr>", { desc = "Claude: accept diff" })
keymap.set("n", "<leader>ad", "<cmd>ClaudinhoDiffDeny<cr>", { desc = "Claude: deny diff" })

-- Nos exploradores de arquivos (neo-tree, netrw, oil, nvim-tree, mini.files):
-- <leader>as adiciona o arquivo sob o cursor ao contexto do Claude
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("ClaudinhoTreeAdd", { clear = true }),
  pattern = { "neo-tree", "netrw", "oil", "NvimTree", "minifiles" },
  callback = function(ev)
    keymap.set("n", "<leader>as", "<cmd>ClaudinhoTreeAdd<cr>", { buffer = ev.buf, desc = "Claude: add file" })
  end,
})
