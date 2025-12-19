# Smoothvim

![Smoothvim screenshot](https://github.com/pedrohrb7/smoothvim/blob/develop/smoothvim.png?raw=true)

### O que é Smoothvim ?

É um compilado de plugins usando LazyVim que buscar ser simples, fácil de usar e fácil de customizar. Uma config simples e objetiva.

### O que _não_ é Smoothvim ?

Uma IDE avançada que vai resolver todos o seus problemas.

### Motivações

Quando comecei a utilizar neovim e aprender a criar minhas próprias configurações,
muitas vezes tinha dificuldades de encontrar uma config que fizesse sentido ou sempre com muitas informações variadas e aleatórias.
Então decidi deixar esse repo com foco em ajudar quem gostaria de começar a utilizar e ter um norte para criar sua própria config.

## Como começar

```
$ git clone https://github.com/pedrohrb7/smoothvim.git ~/.config/smoothvim
$ NVIM_APPNAME=smoothvim nvim
```

## Requisitos

- um terminal
- neovim
- xclip
- ripgrep
- Nerd Font

### Estrutura

```
├── init.lua
├── lua
│   └── smoothvim
│       ├── config
│       │   ├── autocmd.lua
│       │   ├── core.lua
│       │   └── jdtls.lua
│       ├── keymaps // keymaps config
│       │   ├── core.lua
│       │   └── plugins.lua
│       └── plugins
│           ├── copilot.lua
│           ├── git // git related plugins config
│           │   ├── git_diffview.lua
│           │   └── git_signs.lua
│           ├── lsp // lsp related plugins config
│           │   ├── cmp.lua
│           │   ├── conform.lua
│           │   ├── lint.lua
│           │   ├── lsp_config.lua
│           │   └── lsp_signature.lua
│           ├── lualine_themes
│           │   ├── 16base.lua
│           │   ├── palenight.lua
│           │   └── solirized_dark.lua
│           ├── mason
│           │   └── init.lua // mason config
│           ├── nvim_autopairs.lua
            ├── // ...plugins
```

### Inspirações

- [LunarVim](https://github.com/LunarVim/LunarVim)
- [SpaceVim](https://github.com/wsdjeg/SpaceVim)
- [TerminalRoot](https://www.youtube.com/TerminalRootTV)
