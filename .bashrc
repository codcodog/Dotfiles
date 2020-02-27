#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias ll='ls -l'
alias vi='vim'
alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'
alias grep='grep --color=auto'
alias cat='bat'
alias ..='cd ..'
alias ...='cd ../..'
alias setproxy='export ALL_PROXY=socks5://127.0.0.1:1080'
alias unsetproxy='unset ALL_PROXY'
alias myip='curl -i https://ip.cn'

export HISTSIZE=50000
export HISTFILESIZE=100000
export HISTCONTROL=ignoreboth
export HISTIGNORE='ls:ll:pwd:history'
export HISTTIMEFORMAT="%Y-%m-%d %H:%M:%S "

# config go path
export GOPATH=$HOME/.go
export PATH=$PATH:$GOPATH/bin

# parse git branch
parse_branch()
{
  git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/「\1」/'
}

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

red="\[\e[1;38;5;124m\]"
cyan="\[\e[1;38;5;49m\]"
yellow="\[\e[1;38;5;227m\]"
color_end="\[\e[m\]"
PS1="${cyan}\W${color_end} ${yellow}\$(parse_branch)\\$ ${color_end}"
