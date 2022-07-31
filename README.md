# oxocarbon.nvim

A dark and light Neovim theme written in Rust, inspired by [IBM Carbon](https://carbondesignsystem.com/guidelines/color/overview/#themes).

The color palette expands on Nyoom's unique aesthetic and represents a contemporary and ever-changing IBM. Balancing mankind and machine, the colors are harmonious with nature, yet chosen for their luminous quality in the digital world. The oxocarbon color palette is a subset of the broader IBM palette. 

The colorscheme is centered around a vibrant set of blues, combined with an industrial set of grays. The full palette extends from the blue family to the edges of the blue spectrum—even the reds contain a hint of blue. 

The resulting palette is a set of colors that portrays a singular IBM. Of the world and digital. Useful and judicious. Having multiple gray families gives each design the opportunity for nuance and meaningful moments of color. Each experience should be dominated by the grays and the core colors of black, white, and the blue family, allowing the other color families to have vibrancy and provide purpose. 

![nyoombottomtext](https://user-images.githubusercontent.com/71196912/181908773-f7d7a700-d60d-47d2-a3db-3a2bbc6cd1aa.png)

<img width="1311" alt="image" src="https://user-images.githubusercontent.com/71196912/181996667-f1bf7ab0-eba2-4f80-b914-b5f48f51a03e.png">

## Features

- Close to metal. This colorscheme is design to enhance (neo)vim's features, rather than replace them.
- Support for popular plugins, such as Lsp, Treesitter, and Semantic Highlighting
- Fast and Featureful. Supports all the highlights you'll ever need without making a dent on startuptime
- Uses `Termguicolors` but its compatible with 16-color terminals as well
- Written in rust (writing it in rust doesn't really do anything, other than maybe a miniscule startuptime improvement, its just for fun!)

### Plugin support

The colorscheme explicitly adds highlights for the following plugins:
- Vim Diagnostics
- Vim LSP
- Nvim-Treesitter
- Telescope
- Nvim-Notify
- Nvim-Cmp
- NvimTree
- Neogit
- Gitsigns
- Hydra

And many others should "just work!" If you have a plugin that needs explicit highlights, feel free to open an issue or PR and I would be happy to add them.  

## Install

The colorscheme requires the latest stable or nightly neovim (> `v0.7.0`) as well as a working installation of `cargo`. 

If you haven't installed cargo/rust before, please get it from your distros package manager or https://rustup.rs

`./install.sh` will build the colorscheme and place the compiled library in your runtimepath.

### Packer.nvim

```lua
use {'shaunsingh/oxocarbon.nvim', run = './install.sh'}
```

### Vim-Plug

```vimscript
Plug 'shaunsingh/oxocarbon.nvim', { 'do': './install.sh' }
```

### Usage 

For neovim nightly users:
```lua
vim.cmd.colorscheme "oxocarbon"
```

For neovim stable users:
```lua
vim.cmd("colorscheme oxocarbon")
```

For nyoom.nvim users:
```fennel
(import-macros {: colorscheme} :macros.highlight-macros)
(colorscheme oxocarbon)
```

### Configuration

Currently the only configuration is if you want to use the dark or the light theme. This is determined by the value of the `background` option. 
```lua
vim.o.background = "dark" -- triggers dark colorscheme
vim.o.background = "light" -- triggers light colorscheme
```

To modify highlights, please use `:h nvim_set_hl`

## License 

The project is licensed under the MIT license
