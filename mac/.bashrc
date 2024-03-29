#!/bin/bash

# ------------------------------------------------------------------------------
# shortcut
# ------------------------------------------------------------------------------
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias dl='cd ~/Downloads'
alias d='cd ~/Desktop'
alias work='cd ~/workspace'

# ------------------------------------------------------------------------------
# exa
# ------------------------------------------------------------------------------
if [[ $(command -v exa) ]]; then
  alias e='exa --icons --git'
  alias l=e
  alias ls=e
  alias ea='exa -a --icons --git'
  alias la=ea
  alias ee='exa -aahl --icons --git'
  alias ll=ee
  alias et='exa -T -L 3 -a -I "node_modules|.git|.cache" --icons'
  alias lt=et
  alias eta='exa -T -a -I "node_modules|.git|.cache" --color=always --icons | less -r'
  alias lta=eta
  alias l='clear && ls'
fi

# ------------------------------------------------------------------------------
# git
# ------------------------------------------------------------------------------
if [[ $(command -v git) ]]; then
  alias g='git'
  alias gb='git branch'
  alias ga='git add'
  alias gc='git commit -am'
  alias gca='git commit --amend'
  alias gd='git diff'
  alias gds='git diff --staged'
  alias gf='git fetch'
  alias gm='git merge'
  alias gr="git rebase"
  alias grc="git rebase --continue"
  alias gra="git rebase --abort"
  alias gpl='git pull'
  alias gps='git push'
  alias gpso='git push origin'
  alias gstt='git status'
  alias gsts='git stash'
  alias gsw='git switch'
  alias gswc='git switch -c'
  alias gl='git log --oneline'
  alias gbm='git branch --merged'
  alias gbm-all='git branch --merged|egrep -v "\*|develop|main"|xargs git branch' # -d で削除, -D で完全削除
fi

# ------------------------------------------------------------------------------
# terraform
# ------------------------------------------------------------------------------
if [[ $(command -v terraform) ]]; then
  alias tf='terraform'
  alias tfi='terraform init'
  alias tfi='terraform init --auto-approve'
  alias tff='terraform fmt'
  alias tfp='terraform plan'
  alias tfa='terraform apply'
  alias tfi='terraform import'
  alias tfaa='terraform apply --auto-approve'
  alias tfsl='terraform state list'
fi

# ------------------------------------------------------------------------------
# \shellcheck
# ------------------------------------------------------------------------------
if [[ $(command -v shellcheck) ]]; then
  alias sc='shellcheck'
  function schelp() {
    curl -s https://raw.githubusercontent.com/wiki/koalaman/shellcheck/"$1".md
  }
fi

alias help-me='echo "
ctrl+a\t\t:行頭に移動
ctrl+e\t\t:行末に移動
ctrl+h\t\t:後方に1文字削除
meta(esc)+b\t:一語後退
meta(esc)+f\t:一語前進
ctrl+u\t\t:行頭まで削除
ctrl+l\t\t:ターミナルの内容をクリア
ctrl+c\t\t:実行中のコマンドを終了
ctrl+r\t\t:コマンド履歴の検索
ctrl+insert\t:コピー
shift+insert\t:貼り付け
ctrl+d\t\t:ターミナルを強制終了
"'

# ------------------------------------------------------------------------------
# fzf
# ------------------------------------------------------------------------------
# shellcheck source=/dev/null
[ -f "$HOME/.fzf.bash" ] && . ~/.fzf.bash

# ------------------------------------------------------------------------------
# mysql-client
# ------------------------------------------------------------------------------
if [[ $(command -v brew) ]]; then
  if [ "$(brew list | grep -c "^mysql-client@*.*$")" -gt 0 ]; then
    PATH="$(brew --prefix mysql-client)/bin:$PATH"
    export PATH
  fi
fi

# ------------------------------------------------------------------------------
# pre-commit
# ------------------------------------------------------------------------------
if [[ $(command -v pre-commit) ]]; then
  alias pcv="pre-commit -V"
  alias pci="pre-commit install --install-hooks"
  alias pcra="pre-commit run -a"
fi

# ------------------------------------------------------------------------------
# openjdk
# ------------------------------------------------------------------------------
if [[ $(command -v brew) ]]; then
  if [ "$(brew list | grep -c "^openjdk@*.*$")" -gt 0 ]; then
    PATH="$(brew --prefix openjdk@11)/bin:$PATH"
    export PATH
  fi
fi

# ------------------------------------------------------------------------------
# fzf
# ------------------------------------------------------------------------------
if [[ $(command -v brew) ]]; then
  if [ "$(brew list | grep -c "^fzf@*.*$")" -gt 0 ]; then
    # shellcheck source=/dev/null
    [ -f ~/.fzf.zsh ] && . "$HOME/.fzf.zsh"
  fi
fi

# ------------------------------------------------------------------------------
# bat
# ------------------------------------------------------------------------------
if [[ $(command -v bat) ]]; then
  alias cat="bat"
fi

# ------------------------------------------------------------------------------
# Starship
# ------------------------------------------------------------------------------
# see https://starship.rs/ja-jp/guide/
# ※ 一番最後の行に設定が必要
# eval "$(starship init bash)"
