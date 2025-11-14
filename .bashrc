#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls -la --color=auto'
alias grep='grep --color=auto'
alias config='/usr/bin/git --git-dir=$HOME/.cfg --work-tree=$HOME'

export PATH=$PATH:$HOME/bin
export XDG_CONFIG="$HOME/.config"

eval "$(oh-my-posh init bash --config $XDG_CONFIG/omp/gruvbox-material.omp.json)"
