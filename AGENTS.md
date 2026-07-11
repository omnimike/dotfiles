# AGENTS.md

Repository of personal dotfiles. Each subdirectory is a standalone config bundle.

## Structure

Every component lives in its own top-level directory. If a directory contains `install.sh`, running it symlinks (or copies) that component's config into `~/.` or `~/.config/`.

| Directory | Target | Notes |
|---|---|---|
| `zsh/` | `~/.zshrc`, `~/.zshenv` | Shell config |
| `bash/` | `~/.bashrc`, `~/.inputrc`, `~/.profile` | Bash fallback |
| `nvim/` | `~/.config/nvim/init.lua`, `~/.config/nvim/pack/` | Lua-based nvim config |
| `tmux/` | `~/.tmux.conf` | |
| `git/` | `~/.gitconfig` | |
| `hypr/` | `~/.config/hypr/` | Hyprland WM (Lua config) |
| `ssh/` | `~/.ssh/config` | |
| `vscode/` | `~/.config/Code/User/settings.json` | |
| `hammerspoon/` | `~/.hammerspoon/init.lua` | macOS automation |
| `macos/` | system defaults | macOS sysctl defaults (no files authored here) |
| `iterm/` | iTerm2 color scheme | No install script |
| `limine/` | Limine bootloader config | No install script |
| `noctalia/` | Custom tool config | |
| `bin/` | `~/.local/bin/` | Utility scripts (`dotf`, `alert`, `utc`, etc.) |
| `devbox/` | Containerfile | Dev container based on CachyOS with nvim, tmux, zsh, opencode |

## Git submodules

Neovim plugins under `nvim/pack/` are git submodules (~30 plugins listed in `.gitmodules`). After cloning:
```
git submodule update --init --recursive
```

## Install convention

Per-component: `bash <component>/install.sh`
All components: iterate the directories and run each `install.sh` found.

All install scripts use `set -euo pipefail` and symlink with `ln -sf`. The `hypr/install.sh` is the exception — it copies `local_config/` files into `~/.config/hypr/local_config/` but will not overwrite existing ones.

## No build system

There are no tests, linting, CI, or build steps. This repo is flat configuration files managed through symlinks.

## The `dotf` utility

Do not use the dotf utility.

## Commit message conventions

Commit summaries should use a format such as this one:

`[zsh] Added an alias for changing directories`

The body of the commit message is normally left blank.

