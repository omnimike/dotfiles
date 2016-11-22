# alias
alias e='subl'
alias r='ranger --choosedir=$HOME/.rangerdir; LASTDIR=`cat $HOME/.rangerdir`; cd "$LASTDIR"'
alias j='jump'
alias g='git'
alias vg='vagrant'

alias zshrc="vim ~/.zshrc"
alias zshreload="source ~/.zshrc"
alias vimrc="vim ~/.vimrc"

# variables
export FZF_DEFAULT_COMMAND='ag -g ""'
export PATH="$HOME/bin:$PATH"
export EDITOR='vim'

# plugins
source ~/conf/zsh/antigen.zsh

antigen use oh-my-zsh

# oh-my-zsh plugins
antigen bundle git
antigen bundle osx
antigen bundle sublime
antigen bundle vagrant
antigen bundle command-not-found

#other plugins
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle jocelynmallon/zshmarks
antigen bundle supercrabtree/k

antigen apply

# theme
antigen theme pure

# vim keybindings
bindkey -v

if [ -e ~/.zshrc-local ]; then
    source ~/.zshrc-local
fi
