if status is-interactive
    # Commands to run in interactive sessions can go here
    fish_vi_key_bindings
    fish_add_path ~/dotfiles/bin
    set -Ux EDITOR nvim
end
