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

## Post install

Plugins are installed automatically by `vim.pack` on the first start. The
external tools below are not.

### 1. System packages

Example for Void Linux (`xbps`); use your distro's package manager otherwise.

```
$ sudo xbps-install -S ripgrep fd ImageMagick make go luarocks lazydocker
$ sudo xbps-install -S xclip          # X11
$ sudo xbps-install -S wl-clipboard   # Wayland
```

- `ripgrep` - Telescope `live_grep` (`<leader>fw`)
- `xclip` / `wl-clipboard` - system clipboard (`clipboard=unnamedplus`)
- `ImageMagick` - image.nvim (`processor = "magick_cli"`)
- `go` - required by Mason to build `gopls`, `gofumpt` and `revive`
- `luarocks` - required by Mason to install `luacheck`
- `lazygit` / `lazydocker` - `<leader>lg` / `<leader>ld`
- `node` / `npm` and `python3` (with `venv`) - required by most Mason packages

### 2. Rust

`rust_analyzer` is not installed through Mason, so it always matches the
active toolchain:

```
$ rustup component add rust-analyzer rustfmt clippy
```

### 3. LSPs, linters and formatters (Mason)

`mason-lspconfig` runs with `automatic_enable = false`, so nothing is
installed for you. Inside Neovim:

```
:MasonInstall lua-language-server pyright bash-language-server typescript-language-server gopls clangd efm dockerfile-language-server json-lsp css-lsp emmet-ls
:MasonInstall luacheck flake8 black prettierd fixjson shellcheck shfmt cpplint revive gofumpt
:MasonInstall prettier yamlfmt stylua ktlint clang-format palantir-java-format xmlformatter
```

ESLint is taken from each project's `node_modules`, so it doesn't need a
global install.

### 4. Java

`jdtls` is managed by nvim-java, which downloads its own JDK the first time
a `.java` file is opened. Optionally, install JDKs with
[SDKMAN](https://sdkman.io); every JDK under `~/.sdkman/candidates/java` is
handed to jdtls as a project runtime.

### 5. Terminal

image.nvim uses the `kitty` backend, so image previews only work in a
terminal that supports the kitty graphics protocol (kitty, ghostty,
wezterm). A Nerd Font must be set as the terminal font.

### 6. Check

```
:checkhealth vim.pack mason vim.lsp conform telescope image
```

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
