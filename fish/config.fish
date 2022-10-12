fish_add_path ~/dotfiles/bin
fish_add_path ~/.cargo/bin

if status is-interactive
    # Commands to run in interactive sessions can go here

    fish_vi_key_bindings
    set -Ux EDITOR nvim

    alias e nvim
    alias fishrc "e ~/.config/fish/config.fish"
    alias j to
    alias tm tmux
    alias tm 'tmux attach || tmux new'
    alias gpb 'git push origin $(git_current_branch)'
    alias gpbf 'git push origin $(git_current_branch) --force-with-lease'

    alias vimrc "e ~/.vimrc"
    alias vimrcl "e ~/.vimrc-local"
    alias vimrclp "e ~/.vimrc-local-plugins"
    alias tmuxrc "e ~/.tmux.conf"
    alias tmuxrcl "e ~/.tmux-local.conf"
    alias hammerspoonrc "e ~/.hammerspoon/init.lua"
    alias karabinerrc "e ~/.config/karabiner/karabiner.json"
    alias sshconfig "e ~/.ssh/config"
end
