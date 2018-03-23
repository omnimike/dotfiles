
# variables
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*" 2> /dev/null'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

local TEX_PATH="/Library/TeX/texbin"
local GO_PATH="/usr/local/opt/go/libexec/bin:$HOME/go/bin"
local YARN_PATH="$HOME/.config/yarn/global/node_modules/.bin"
local LOCAL_PATH="$HOME/.local/bin"
local COMPOSER_PATH="$HOME/.composer/vendor/bin"
local SUBL_PATH="/Applications/Sublime Text.app/Contents/SharedSupport/bin"
local RUST_PATH="$HOME/.cargo/bin"
local BREW_PATH="/usr/local/bin"
export PATH="$PATH:$HOME/bin:$BREW_PATH:$RUST_PATH:$SUBL_PATH:$LOCAL_PATH:$YARN_PATH:$GO_PATH:$TEX_PATH:$COMPOSER_PATH"
export GOPATH="$HOME/go"
export EDITOR='vim'
export VISUAL='vim'
