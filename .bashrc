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

# fzf 配置 
export PATH="$PATH:/usr/local/php/bin:/usr/local/php/sbin"
alias ff='fzf --height 30%'
fh() { 
  eval $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | ff +s --tac | sed 's/ *[0-9]* *//')
}

PS1='[\u@\h \W]\$ '
