# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Personal dotfiles repository for Michael F. Configuration files are organized by tool, each in its own directory with an `install.sh` script that symlinks configs into the appropriate locations.

## Key Commands

- **Install a config:** `dotf install <tool>` (e.g., `dotf install nvim`) — runs `<tool>/install.sh`
- **Save changes:** `dotf save` — stages all, commits with message "save", and pushes
- **Pull changes:** `dotf load`
- **Check status:** `dotf status`

The `dotf` script lives in `bin/dotf` and is added to `$PATH` via `zsh/zshenv.zsh`.

## Structure

Each tool directory contains config files and an `install.sh` that creates symlinks to `$HOME`:
- `zsh/` → `~/.zshrc`, `~/.zshenv`
- `nvim/` → `~/.config/nvim/init.lua` and `~/.config/nvim/pack/`
- `vim/` → `~/.vimrc` and `~/.vim/pack/`
- `tmux/` → `~/.tmux.conf`
- `bash/`, `fish/`, `emacs/`, `kak/`, `hammerspoon/`, `karabiner/`, `alacritty/`, `sublime/`, `vscode/`, `idea/`, `atom/` — similar pattern

## Plugin Management

Vim/Neovim plugins are managed as **git submodules** using native packages:
- Vim plugins: `vim/pack/core/start/`
- Neovim plugins: `nvim/pack/omnimike/start/`

To add a plugin: `git submodule add <url> nvim/pack/omnimike/start/<plugin-name>`

## Key Config Files

- **`nvim/init.lua`** — Main neovim config (Lua). Leader is `<Space>`. Uses telescope, nvim-tree, treesitter, nvim-cmp, lualine, trouble, which-key, LSP via nvim-lspconfig, none-ls, gitsigns, noice, claudecode, and mini (ai, comment, surround).
- **`zsh/zshrc.zsh`** — Shell config with vi keybindings, fzf integration, aliases. Sources `~/.zshrc-local` for machine-specific config.
- **`zsh/zshenv.zsh`** — PATH setup, adds `~/dotfiles/bin` to PATH.
- **`gitconfig`** — Git config with rebase-by-default workflow.
- **`devbox/init.sh`** — Bootstraps a new dev environment (Arch-based, uses pacman).

## Local Overrides

Machine-specific config goes in local files (not tracked):
- `~/.zshrc-local` — sourced at end of zshrc
- `~/.vimrc-local` — sourced at end of nvim init.lua and vim init.vim
