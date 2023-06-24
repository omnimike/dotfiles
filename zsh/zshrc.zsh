HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

setopt append_history
setopt complete_in_word
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_save_no_dups
setopt hist_reduce_blanks
setopt share_history
setopt inc_append_history

zsh_prompt_newline=$'\n'
zsh_prompt_start="${zsh_prompt_newline}%F{blue}%*%F{none} %F{green}%~%F{none}"
zsh_prompt_end="${zsh_prompt_newline}%F{magenta}$%F{none} "
export PROMPT="${zsh_prompt_start}${zsh_prompt_end}"

function preexec() {
  zsh_prompt_timer=${zsh_prompt_timer:-$SECONDS}
}

function precmd() {
  if [ $zsh_prompt_timer ]; then
    local total_secs=$(($SECONDS - $zsh_prompt_timer))
    unset zsh_prompt_timer
    local -a timer
    local days=$((total_secs / 86400))
    local hours=$(($((total_secs / 3600)) % 24))
    local mins=$(($((total_secs / 60)) % 60))
    local secs=$((total_secs % 60))
    if [[ $days -gt 0 ]]; then
      timer+="${days}d"
    fi
    if [[ $hours -gt 0 ]]; then
      timer+="${hours}h"
    fi
    if [[ $mins -gt 0 ]]; then
      timer+="${mins}m"
    fi
    if [[ $secs -gt 0 ]]; then
      timer+="${secs}s"
    fi
    if [[ $total_secs -gt 0 ]]; then
      PROMPT="${zsh_prompt_start} %F{yellow}${timer}%F{none} ${zsh_prompt_end}"
      return
    fi
  fi
  PROMPT="${zsh_prompt_start}${zsh_prompt_end}"
}

# This allows us to use the R language
disable r

export EDITOR='nvim'
export VISUAL='nvim'

# alias
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias l='ls -CFh'
alias la='ls -Ah'
alias ll='ls -alFh'
alias ls='ls --color=auto'

alias e='nvim'
alias tm='tmux attach || tmux new'
alias gpb='git push origin $(git_current_branch)'
alias gpbf='git push origin $(git_current_branch) --force-with-lease'

alias zshrc="e ~/.zshrc"
alias zshrcl="e ~/.zshrc-local"
alias zshenv="e ~/.zshenv"
alias zshreload="source ~/.zshrc"
alias vimrc="e ~/.vimrc"
alias vimrcl="e ~/.vimrc-local"
alias nvimrc="e ~/.config/nvim/init.lua"
alias nvimpack="cd ~/.config/nvim/pack/omnimike/start"
alias tmuxrc="e ~/.tmux.conf"
alias tmuxrcl="e ~/.tmux-local.conf"
alias hammerspoonrc="e ~/.hammerspoon/init.lua"
alias karabinerrc="e ~/.config/karabiner/karabiner.json"
alias kakrc="e ~/.config/kak/kakrc"
alias hxrc="e ~/.config/helix/config.toml"
alias sshconfig="e ~/.ssh/config"

alias jdotfiles="cd ~/dotfiles"
alias jdotf="cd ~/dotfiles"
alias jssh="cd ~/.ssh"

# lldb needs to use the system python
alias lldb='PATH=/usr/bin:$PATH lldb'

ZSH_THEME=""

# vim keybindings
bindkey -v
bindkey '^p' up-history
bindkey '^n' down-history
bindkey '^v' edit-command-line

# Bar cursor during insert mode
zle-keymap-select () {
  if [ $KEYMAP = vicmd ]; then
      printf "\033[2 q"
  else
      printf "\033[6 q"
  fi
}
zle -N zle-keymap-select

zle-line-init () {
  zle -K viins
  printf "\033[6 q"
}
zle -N zle-line-init


# install pyenv
usepyenv() {
    eval "$(pyenv init -)"
}

# install nvm
usenvm() {
    source "/usr/local/opt/nvm/nvm.sh"
}

usejenv() {
    export PATH="$HOME/.jenv/bin:$PATH"
    eval "$(jenv init -)"
}

if [[ -e ~/.zshrc-local ]]; then
    source ~/.zshrc-local
fi

# Custom functions
# fcd - cd to selected directory
fcd() {
  local dir
  dir=$(find ${1:-*} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}

# fda - including hidden directories
fcda() {
  local dir
  dir=$(find ${1:-.} -type d 2> /dev/null | fzf +m) && cd "$dir"
}

# fe - edit file
fe() {
    local file
    file=$(fzf +m) || return
    e $file
}

# fco - checkout git branch/tag
fco() {
  local tags branches target
  tags=$(
    git tag | awk '{print "\x1b[31;1mtag\x1b[m\t" $1}') || return
  branches=$(
    git branch --all | grep -v HEAD             |
    sed "s/.* //"    | sed "s#remotes/[^/]*/##" |
    sort -u          | awk '{print "\x1b[34;1mbranch\x1b[m\t" $1}') || return
  target=$(
    (echo "$tags"; echo "$branches") |
    fzf --no-hscroll --ansi +m -d "\t" -n 2) || return
  git checkout $(echo "$target" | awk '{print $2}')
}

# fh - repeat history
fh() {
  print -z $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed 's/ *[0-9]* *//')
}

# export FZF_DEFAULT_COMMAND='fd  --type f --hidden --follow --exclude .git'
export FZF_DEFAULT_COMMAND='rg  --files'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

[[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh
