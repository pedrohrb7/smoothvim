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

### Structure

```
├── init.lua
├── lua
│   └── smoothvim
│       ├── config
│       │   ├── autocmds.lua
│       │   ├── cmp.lua
│       │   ├── core.lua
│       │   ├── formatter.lua
│       │   ├── keymaps.lua
│       │   ├── lint.lua
│       │   ├── lsp.lua
│       │   └── theme.lua
│       └── plugins/packs
```

### Related projects and inspirations

- [LunarVim](https://github.com/LunarVim/LunarVim)
- [SpaceVim](https://github.com/wsdjeg/SpaceVim)
- [TerminalRoot](https://www.youtube.com/TerminalRootTV)

- Last config based on -> ["https://www.youtube.com/watch?v=lljs_7xB7Ps"]
