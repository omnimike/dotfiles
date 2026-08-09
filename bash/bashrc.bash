
# Exit if this shell isn't interactive
[[ $- != *i* ]] && return

export EDITOR='nvim'
export VISUAL='nvim'
export HGEDITOR='nvim'

export HISTCONTROL=ignoreboth:erasedups
shopt -s histappend

set -o vi
bind '"\C-p": previous-history'
bind '"\C-n": next-history'
bind '"\C-a": beginning-of-line'
bind '"\C-e": end-of-line'

# Load aliases
[[ -f ~/.dotfiles/zsh/alias.sh ]] && source ~/.dotfiles/zsh/alias.sh

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

export FZF_DEFAULT_COMMAND='rg --files'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
eval "$(fzf --bash)"

[[ -f ~/.bashrcl ]] && source ~/.bashrcl
