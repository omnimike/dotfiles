# alias
alias vg='vagrant'
alias gpb='git push origin $(git_current_branch)'
alias gpbf='git push origin $(git_current_branch) -f'

# variables
export FZF_DEFAULT_COMMAND='ag -g ""'
local ANACONDA_PATH="$HOME/uni/da/anaconda3/bin"
local TEX_PATH="/Library/TeX/texbin"
local GO_PATH="/usr/local/opt/go/libexec/bin:$HOME/go/bin"
local YARN_PATH="$HOME/.config/yarn/global/node_modules/.bin"
local LOCAL_PATH="$HOME/.local/bin"
local COMPOSER_PATH="$HOME/.composer/vendor/bin"
local SUBL_PATH="/Applications/Sublime Text.app/Contents/SharedSupport/bin"
export PATH="$PATH:$HOME/bin:$SUBL_PATH:$LOCAL_PATH:$YARN_PATH:$GO_PATH:$ANACONDA_PATH:$TEX_PATH:$COMPOSER_PATH"
export GOPATH="$HOME/go"
export EDITOR='vim'
