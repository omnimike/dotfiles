
export EDITOR='nvim'
export VISUAL='nvim'
export HGEDITOR='nvim'

set -o vi
bind '"\C-p": previous-history'
bind '"\C-n": next-history'
bind '"\C-a": beginning-of-line'
bind '"\C-e": end-of-line'

# alias
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

alias q='exit'
alias e='nvim'
alias c='opencode'
alias tm='tmux attach || tmux new'
alias gpb='git push origin $(git_current_branch)'
alias gpbf='git push origin $(git_current_branch) --force-with-lease'

alias jdotf='cd ~/.dotfiles'

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
alias sshconfig="e ~/.ssh/config"

timer_show=""

__bash_timer_start() {
  timer=${timer:-$SECONDS}
}

__bash_timer_stop() {
  if [ -n "${timer+x}" ]; then
    local i=$(($SECONDS - $timer))
    local days=$((i / 86400))
    local hours=$(( (i / 3600) % 24 ))
    local mins=$(( (i / 60) % 60 ))
    local secs=$((i % 60))
    timer_show=""
    if [ "$days" -gt 0 ]; then timer_show="${timer_show}${days}d "; fi
    if [ "$hours" -gt 0 ]; then timer_show="${timer_show}${hours}h "; fi
    if [ "$mins" -gt 0 ]; then timer_show="${timer_show}${mins}m "; fi
    if [ "$secs" -gt 0 ]; then timer_show="${timer_show}${secs}s"; fi
  fi
  unset timer
}

trap '__bash_timer_start' DEBUG

__bash_precmd() {
  __bash_timer_stop
  local timer_part=""
  [ -n "$timer_show" ] && timer_part=" \[\e[0;33m\]${timer_show}\[\e[m\]"

  PS1="\n\[\e[0;33m\]\t\[\e[m\] \[\e[0;34m\]\h\[\e[m\] \[\e[0;32m\]\w\[\e[m\]${timer_part}\n\[\e[0;35m\]\$\[\e[m\] "
}

export PROMPT_COMMAND=__bash_precmd
