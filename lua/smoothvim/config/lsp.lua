-- Enable LSP servers for Neovim 0.11+
vim.lsp.enable({
  "ts_ls",
  "tailwindcss",
  "eslint",
  "lua_ls",
  "cssls",
  "html",
  "jsonls",
  "yamlls",
})

-- Load Lsp on-demand, e.g: eslint is disable by default
-- e.g: We could enable eslint by set vim.g.lsp_on_demands = {"eslint"}
if vim.g.lsp_on_demands then
  vim.lsp.enable(vim.g.lsp_on_demands)
end

-- vim.lsp.config("lua_ls")
-- vim.lsp.config("tailwindcss")
-- vim.lsp.config("eslint")
-- vim.lsp.config("ts_ls")

-- LSP settings
-- local function augroup(name)
--   return vim.api.nvim_create_augroup("user_" .. name, { clear = true })
-- end

-- local default_keymaps = {
--   { keys = "<leader>ca", func = vim.lsp.buf.code_action, desc = "Code Actions" },
--   { keys = "<leader>cr", func = vim.lsp.buf.rename, desc = "Code Rename" },
--   { keys = "<leader>k", func = vim.lsp.buf.hover, desc = "Hover Documentation", has = "hoverProvider" },
--   { keys = "K", func = vim.lsp.buf.hover, desc = "Hover (alt)", has = "hoverProvider" },
--   { keys = "gd", func = vim.lsp.buf.definition, desc = "Goto Definition", has = "definitionProvider" },
--   { keys = "<leader>d", func = vim.diagnostic.open_float, desc = "Show line diagnostics" },
--   { keys = "<leader>rn", func = vim.lsp.buf.rename, desc = "Smart rename" },
-- }

-- local completion = vim.g.completion_mode or "blink" -- or 'native'
-- vim.api.nvim_create_autocmd("LspAttach", {
--   group = augroup("lsp_attach"),
--   callback = function(args)
--     local client = vim.lsp.get_client_by_id(args.data.client_id)
--     local buf = args.buf
--
--     if client then
--       -- Built-in completion
--       -- if completion == "native" and client:supports_method("textDocument/completion") then
--       if client:supports_method("textDocument/completion") then
--         vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
--       end
--
--       -- Inlay hints
--       if client:supports_method("textDocument/inlayHint") then
--         vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
--       end
--
--       if client:supports_method("textDocument/documentColor") then
--         vim.lsp.document_color.enable(true, args.buf, {
--           style = "background", -- 'background', 'foreground', or 'virtual'
--         })
--       end
--
--       for _, km in ipairs(default_keymaps) do
--         -- Only bind if there's no `has` requirement, or the server supports it
--         if not km.has or client.server_capabilities[km.has] then
--           vim.keymap.set(
--             km.mode or "n",
--             km.keys,
--             km.func,
--             { buffer = buf, desc = "LSP: " .. km.desc, nowait = km.nowait }
--           )
--         end
--       end
--     end
--   end,
-- })

vim.cmd("set completeopt+=noselect")
require("luasnip.loaders.from_vscode").lazy_load()

require("blink.cmp").setup({
	-- signature = { enabled = true },
	-- completion = {
	-- 	documentation = { auto_show = true, auto_show_delay_ms = 500 },
	-- 	menu = {
	-- 		auto_show = true,
	-- 		draw = {
	-- 			treesitter = { "lsp" },
	-- 			columns = { { "kind_icon", "label", "label_description", gap = 1 }, { "kind" } },
	-- 		},
	-- 	},
	-- },
})
