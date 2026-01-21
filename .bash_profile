#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

# Launch Hyprland on new profile that isn't an SSH or TMUX session
[[ -z $SSH_CONNECTION && -z $TMUX ]] && Hyprland
