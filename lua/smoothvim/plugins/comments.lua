local comment = require("Comment")
-- local ts_context_commentstring = require("ts_context_commentstring.integrations.comment_nvim")

require("ts_context_commentstring").setup({
  enable_autocmd = true,
})
comment.setup({})
