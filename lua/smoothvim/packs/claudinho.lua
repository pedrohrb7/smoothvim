vim.pack.add({
  { src = "https://github.com/pedrohrb7/claudinho.nvim", version = "develop" },
})

-- Payload default do Claudinho (lua/claudinho/config.lua), explícito para facilitar ajustes.
require("claudinho").setup({
  port_range = { min = 10000, max = 65535 },
  terminal_cmd = nil, -- comando do Claude; nil usa "claude"
  -- CLAUDE_CODE_NO_FLICKER = "1" faz o plugin ser fullscreen [classic | fullscreen]
  env = { CLAUDE_CODE_NO_FLICKER = "1" }, -- variáveis de ambiente extras do terminal (strings)
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
    layout = "left", -- "left" | "right" | "bottom" | "float" | "tab"
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

keymap.set({ "n", "t", "i" }, "<leader>cl", "<cmd>Claudinho<cr>", { desc = "Claude: toggle" })
keymap.set("n", "<leader>cf", "<cmd>ClaudinhoFocus<cr>", { desc = "Claude: focus" })
keymap.set("n", "<leader>cr", "<cmd>Claudinho --resume<cr>", { desc = "Claude: resume" })
keymap.set("n", "<leader>ab", "<cmd>ClaudinhoAdd %<cr>", { desc = "Claude: add current buffer" })
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
