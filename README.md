# Smoothvim

![Smoothvim screenshot](https://github.com/pedrohrb7/smoothvim/blob/smooth-vanilla/w2.png?raw=true)

### What is Smoothvim ?

It's a neovim setup focused on simplicity and ease of use.

### Why I created Smoothvim ?

When I started to use neovim and learn to create my own configurations,
many times I had difficulties finding a config that made sense or always with a lot of varied and random information.
So I decided to leave this repo focused on helping those who would like to start using and have a guide to create their own config in a simple way.

## How to use

```
$ git clone https://github.com/pedrohrb7/smoothvim.git ~/.config/smoothvim
$ NVIM_APPNAME=smoothvim nvim
```

## Requirements

- um terminal
- neovim
- xclip
- ripgrep
- Nerd Font

### Structure

```
├── init.lua
├── lua
│   └── smoothvim
│       ├── config
│       │   ├── autocmd.lua
│       │   ├── core.lua
│       │   ├── jdtls.lua
│       │   ├── core.lua
│       │   └── jdtls.lua
│       └── plugins 
```

### Related projects and inspirations

- [LunarVim](https://github.com/LunarVim/LunarVim)
- [SpaceVim](https://github.com/wsdjeg/SpaceVim)
- [TerminalRoot](https://www.youtube.com/TerminalRootTV)
