vim.pack.add({
  { src = "https://github.com/nvim-telescope/telescope.nvim" },
  { src = "https://github.com/nvim-telescope/telescope-ui-select.nvim" },

  { src = "https://github.com/3rd/image.nvim" },
})

local telescope = require("telescope")
local actions = require("telescope.actions")
local builtin = require("telescope.builtin")
local previewers = require("telescope.previewers")
local image_api = require("image").setup({
  backend = "kitty",
  processor = "magick_cli",
  max_width_window_percentage = 80,
  max_height_window_percentage = 80,
})

local image_extensions = { "png", "jpg", "jpeg", "gif", "webp", "avif", "bmp" }

local current_image = nil
local current_image_path = nil

local function is_image(filepath)
  local ext = filepath:match("^.+%.(%a+)$")
  return ext ~= nil and vim.tbl_contains(image_extensions, ext:lower())
end

local function image_buffer_previewer_maker(filepath, bufnr, opts)
  if current_image and current_image_path ~= filepath then
    current_image:clear()
    current_image = nil
  end
  current_image_path = filepath

  if is_image(filepath) then
    local ok, img = pcall(image_api.from_file, filepath, {
      window = opts.winid,
      buffer = bufnr,
    })
    if ok and img then
      current_image = img
      current_image:render()
    else
      previewers.buffer_previewer_maker(filepath, bufnr, opts)
    end
  else
    previewers.buffer_previewer_maker(filepath, bufnr, opts)
  end
end

telescope.setup({
  defaults = {
    buffer_previewer_maker = image_buffer_previewer_maker,
    path_display = { "smart" },
    file_ignore_patterns = {
      "node_modules",
      ".next",
      "dist",
      "build",
      "bundle",
      ".git",
      ".yarn",
    },
    mappings = {
      i = {
        ["<C-k>"] = actions.move_selection_previous, -- move to prev result
        ["<C-j>"] = actions.move_selection_next, -- move to next result
      },
    },
  },
  pickers = {
    colorscheme = {
      enable_preview = true,
    },
    find_files = {
      theme = "ivy",
      hidden = true,
    },
    live_grep = {
      theme = "ivy",
      hidden = true,
    },
    buffers = {
      theme = "ivy",
      hidden = true,
    },
    git_status = {
      theme = "ivy",
      hidden = true,
    },
    diagnostics = {
      theme = "ivy",
      hidden = true,
    },
  },
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_ivy({}),
    },
  },
})

telescope.load_extension("ui-select")

local keymap = vim.keymap
local opts = { noremap = true, silent = true }

keymap.set("n", "<leader>ff", builtin.find_files, opts) -- Telescope Find file" })
keymap.set("n", "<leader>fw", builtin.live_grep, opts) -- Telescope Search by word" })
keymap.set("n", "<leader>fb", builtin.buffers, opts) -- Search in open buffers" })
keymap.set("n", "<leader>fg", builtin.git_status, opts) -- Search in git edited buffers
keymap.set("n", "<leader>fd", builtin.diagnostics, opts) -- Telescope show diagnostics
