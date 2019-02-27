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
alias phpcs='phpcs fix -v --diff --diff-format=udiff --dry-run'
alias ..='cd ..'
alias ...='cd ../..'

export HISTSIZE=5000
export HISTFILESIZE=10000
export HISTCONTROL=ignoreboth
export HISTIGNORE='ls:ll:pwd:history'
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

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
PS1="${red}\u@\h${color_end} ${cyan}\W${color_end} ${yellow}\$(parse_branch)\\$ ${color_end}"
