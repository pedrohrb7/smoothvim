# Smoothvim

![Smoothvim screenshot](https://github.com/pedrohrb7/smoothvim/blob/develop/smoothvim.png?raw=true)

### O que é Smoothvim ?

É um compilado de plugins usando LazyVim que buscar ser simples, fácil de usar e fácil de customizar. Uma config simples e objetiva.

### O que _não_ é Smoothvim ?

Uma IDE avançada que vai resolver todos os seus problemas.

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

- um terminal (recomendo Kitty para que as font ligatures funcionem)
- neovim
- xclip
- ripgrep
- Nerd Font

### Estrutura

```
├── ftplugin
│   └── java.lua - Configuração para executar em projetos Java. Remova se precisar.
├── init.lua
└── lua
    └── smoothvim
        ├── config
        │   └── core.lua    - Configs nativas do vim
        ├── custom
        │   └── init.lua    - Arquivo/Diretório para instalar novos plugins, caso queira manter separado
        ├── keymaps
        │   ├── core.lua    - Keymaps que não são de plugins
        │   └── plugins.lua - Todas as keymaps dos plugins apenas
        ├── lazy.lua        - https://github.com/LazyVim/LazyVim
        └── plugins
             ├── git
             │   └── plugins de git
             ├── lsp
             │   └── configurações de LSP (https://github.com/neovim/nvim-lspconfig)
             └── mason
             │    └── configurações do mason (https://github.com/mason-org/mason.nvim)
             ├── Restante dos plugins
```

### Qual usar ?

As configs ficam divididas em branchs:

- **main**: Uma config estável e funcional.
- **develop**: Uma config onde testo novos plugins, pode quebrar em algum momento.
- **smooth-vanilla**: Uma config focada em ser o mais clean possível, mantendo apenas plugins como: Mason, LSPs, Treesitter e etc.

### Inspirações

- [LunarVim](https://github.com/LunarVim/LunarVim)
- [SpaceVim](https://github.com/wsdjeg/SpaceVim)
- [TerminalRoot](https://www.youtube.com/TerminalRootTV)
