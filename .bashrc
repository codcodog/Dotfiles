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
alias ..='cd ..'
alias ...='cd ../..'

HISTCONTROL=erasedups
HISTSIZE=5000
HISTFILESIZE=5000

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

PS1='[\u@\h \W]\$ '
