#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls -la --color=auto'
alias grep='grep --color=auto'
alias config='/usr/bin/git --git-dir=$HOME/.cfg --work-tree=$HOME'

export PATH=$PATH:$HOME/bin:$HOME/scripts
export XDG_CONFIG="$HOME/.config"

# Notify if any uncommited changes to .config repo
status=$(config status --short)
if [[ -n $status ]]; then
  echo -e "\e[1;31m${#status[@]} uncommited change/s to .config repo\e[0m"
fi

# Execute oh-my-posh with given theme
eval "$(oh-my-posh init bash --config $XDG_CONFIG/omp/gruvbox-material.omp.json)"
