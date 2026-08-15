# Smoothvim

![Smoothvim screenshot](https://github.com/pedrohrb7/smoothvim/blob/smooth-vanilla/w2.png?raw=true)

## How to use

```
$ git clone https://github.com/pedrohrb7/smoothvim.git ~/.config/smoothvim
$ NVIM_APPNAME=smoothvim nvim

# or 

$ git clone https://github.com/pedrohrb7/smoothvim.git ~/.config/nvim
$ nvim

```

## Requirements

- Terminal
- neovim 0.12
- xclip
- ripgrep
- Nerd Font
- ImageMagick (for Telescope image preview via image.nvim)

### Structure

```
|-- init.lua
|-- lua
|   `-- smoothvim
|       |-- config
|       |   |-- autocmds.lua
|       |   |-- core.lua
|       |   |-- init.lua
|       |   `-- keymaps.lua
|       `-- packs
|           |-- git.lua
|           |-- image.lua
|           |-- init.lua
|           |-- lsp.lua
|           |-- neotree.lua
|           |-- statusline.lua
|           |-- telescope.lua
|           `-- theme.lua
|-- nvim-pack-lock.json
```

### Related projects and inspirations

- [LunarVim](https://github.com/LunarVim/LunarVim)
- [SpaceVim](https://github.com/wsdjeg/SpaceVim)
- [TerminalRoot](https://www.youtube.com/TerminalRootTV)

- Last config inspired by -> ["https://www.youtube.com/watch?v=lljs_7xB7Ps"]
