
export EDITOR='vim'
export VISUAL='vim'
export HGEDITOR='code-fb -w'

set -o vi
bind '"\C-p": previous-history'
bind '"\C-n": next-history'

# alias
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

alias e='code-fb'
alias tm='tmux attach || tmux new'
alias vg='vagrant'
alias gpb='git push origin $(git_current_branch)'
alias gpbf='git push origin $(git_current_branch) --force-with-lease'

alias zshrc="e ~/.zshrc"
alias zshrcl="e ~/.zshrc-local"
alias zshenv="e ~/.zshenv"
alias zshreload="source ~/.zshrc"
alias bashrc="e ~/dotfiles/bash/bashrc.bash"
alias bashenv="e ~/dotfiles/bash/profile.bash"
alias inputrc="e ~/dotfiles/bash/inputrc.bash"
alias vimrc="e ~/.vimrc"
alias vimrcl="e ~/.vimrc-local"
alias vimrclp="e ~/.vimrc-local-plugins"
alias tmuxrc="e ~/.tmux.conf"
alias tmuxrcl="e ~/.tmux-local.conf"
alias hammerspoonrc="e ~/.hammerspoon/init.lua"
alias karabinerrc="e ~/.config/karabiner/karabiner.json"
alias kakrc="e ~/.config/kak/kakrc"
alias sshconfig="e ~/.ssh/config"

alias jfbcode="cd ~/fbsource/fbcode"
alias jconfigerator="cd ~/configerator"
alias jicsp="cd ~/icsp"

export PS1='\n\[\e[0;34m\]\t\[\e[m\] \[\e[0;32m\]\w\[\e[m\] \n\[\e[0;35m\]\$\[\e[m\] '
