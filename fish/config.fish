fish_add_path ~/dotfiles/bin
fish_add_path ~/.cargo/bin

if status is-interactive
    # Commands to run in interactive sessions can go here

    fish_vi_key_bindings
    set -Ux EDITOR nvim

    alias e nvim
    alias fishrc "e ~/.config/fish/config.fish"
    alias j to
end
