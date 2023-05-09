# Share history between sessions
setopt APPEND_HISTORY
# Allow tab completion in the middle of a word.
setopt COMPLETE_IN_WORD
# Expire duplicate entries first when trimming history.
setopt HIST_EXPIRE_DUPS_FIRST
# Dont record an entry that was just recorded again.
setopt HIST_IGNORE_DUPS
# Delete old recorded entry if new entry is a duplicate.
setopt HIST_IGNORE_ALL_DUPS
# Dont record an entry starting with a space.
setopt HIST_IGNORE_SPACE
# Dont write duplicate entries in the history file.
setopt HIST_SAVE_NO_DUPS
# Remove superfluous blanks before recording entry.
setopt HIST_REDUCE_BLANKS

NEWLINE=$'\n'
export PROMPT="$NEWLINE%F{blue}%*%F{none} %F{green}%~%F{none}$NEWLINE%F{magenta}$%F{none} "

# This allows us to use the R language
disable r

export EDITOR='nvim'
export VISUAL='nvim'

# alias
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
alias vimrclp="e ~/.vimrc-local-plugins"
alias tmuxrc="e ~/.tmux.conf"
alias tmuxrcl="e ~/.tmux-local.conf"
alias hammerspoonrc="e ~/.hammerspoon/init.lua"
alias karabinerrc="e ~/.config/karabiner/karabiner.json"
alias kakrc="e ~/.config/kak/kakrc"
alias sshconfig="e ~/.ssh/config"

alias jdotfiles="cd ~/dotfiles"

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

export FZF_DEFAULT_COMMAND='fd  --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

[[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh

