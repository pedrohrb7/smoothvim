vim.pack.add({
  { src = "https://github.com/nvim-neo-tree/neo-tree.nvim"},

  -- dependencies
  { src = "https://github.com/MunifTanjim/nui.nvim"},
})

local neoTree = require("neo-tree")
    neoTree.setup({
      close_if_last_window = true,
      window = {
        position = "right",
        mappings = {
          ["h"] = "close_node",
          ["l"] = "toggle_node",
          ["A"] = "add_directory",
          ["Y"] = function(state)
            local node = state.tree:get_node()
            local filepath = node:get_id()
            vim.fn.setreg('"', filepath) -- set to the default register
            vim.notify("Copied: " .. filepath)
          end,
        },
      },
      filesystem = {
        filtered_items = {
          hide_dotfiles = false,
          hide_gitignored = false,
        },
        follow_current_file = {
          enabled = true,
        },
      },
      buffers = {
        follow_current_file = {
          enabled = true,
        },
      },
    })

-- keymaps
local keymap = vim.keymap -- for conciseness

--Neo-tree plugin
keymap.set("n", "<leader>ne", ":Neotree toggle<CR>", { desc = "Toggle file explorer" }) -- toggle file explorer
keymap.set("n", "<C-t>", ":Neotree toggle<CR>", { desc = "Alternative map to toggle file explorer" }) -- toggle file explorer
keymap.set("n", "<leader>nb", ":Neotree buffers reveal float<CR>", { desc = "Reveal buffers in modal" })
keymap.set("n", "--", ":Neotree reveal<CR>", { desc = "Reveal file under cursos" })

