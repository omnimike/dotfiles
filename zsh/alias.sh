
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias l='ls -CFh'
alias la='ls -Ah'
alias ll='ls -alFh'
alias ls='ls --color=auto'

alias q='exit'
alias e="$EDITOR"
alias tm='tmux attach || tmux new'
alias z='zellij'
alias c='opencode'
alias d='devbox'
alias de='devbox run nvim'
alias dc='devbox run opencode'
alias dt='devbox run tmux -u'
alias gpb='git push origin $(git_current_branch)'
alias gpbf='git push origin $(git_current_branch) --force-with-lease'

alias zshrc="$EDITOR ~/.zshrc"
alias zshrcl="$EDITOR ~/.zshrc-local"
alias zshenv="$EDITOR ~/.zshenv"
alias zshreload="source ~/.zshrc"
alias bashrc="$EDITOR ~/.dotfiles/bash/bashrc.bash"
alias bashenv="$EDITOR ~/.dotfiles/bash/profile.bash"
alias vimrc="$EDITOR ~/.vimrc"
alias vimrcl="$EDITOR ~/.vimrc-local"
alias nvimrc="$EDITOR ~/.config/nvim/init.lua"
alias nvimpack="cd ~/.config/nvim/pack/omnimike/start"
alias tmuxrc="$EDITOR ~/.tmux.conf"
alias tmuxrcl="$EDITOR ~/.tmux-local.conf"
alias hammerspoonrc="$EDITOR ~/.hammerspoon/init.lua"
alias sshconfig="$EDITOR ~/.ssh/config"

alias jdotfiles="cd ~/.dotfiles"
alias jdotf="cd ~/.dotfiles"
alias jssh="cd ~/.ssh"
alias jcode="cd ~/code"
