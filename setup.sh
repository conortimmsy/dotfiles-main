#!/bin/bash

# Configuration
NAME='Conor Timms'
TIMEZONE=Europe/London
ARCH=$(lscpu | awk '/Architecture/{print $2}')
export XDG_CONFIG_HOME="$HOME"/.config

# Set timezone
sudo rm -f /etc/localtime
sudo ln -s /usr/share/zoneinfo/$TIMEZONE /etc/localtime

# update apt repositories and install packages
sudo apt update
sudo apt install -y \
  locales-all \
  ncdu \
  btop \
  bash-completion \
  shellcheck \
  parallel \
  ripgrep \
  fd-find \
  build-essential \
  cmake \
  openssh-server \
  tmux

# Install OMP
mkdir ~/bin
curl -s https://ohmyposh.dev/install.sh | bash -s -- -d ~/bin

# Configure git
echo .DS_Store >>~/.gitignore_global
echo plan_file >>~/.gitignore_global
echo .vscode >>~/.gitignore_global
git config --global core.excludesfile ~/.gitignore_global
git config --global user.email "timmsconor@gmail.com"
git config --global user.name "Conor Timms"
git config --global push.default current

eval "$(gh completion -s bash)"

# setup lazygit
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | \grep -Po '"tag_name": *"v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_arm64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit -D -t /usr/local/bin/

# Install NeoVim
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-$ARCH.appimage
chmod u+x nvim-linux-$ARCH.appimage
./nvim-linux-$ARCH.appimage --appimage-extract
./squashfs-root/AppRun --version
# Optional: exposing nvim globally.
sudo mv squashfs-root /
sudo ln -s /squashfs-root/AppRun /usr/bin/nvim

# Install fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --all
# Update TLDR
mkdir -p ~/.local/share/tldr
tldr -u

# Install tmux tpm plugin manager
mkdir -p ~/.config/tmux/plugins/tpm
git clone https://github.com/tmux-plugins/tpm ~/.config/plugins/tpm
exec /home/vscode/.config/tmux/plugins/tpm/bin/install_plugins.sh

exec /usr/sbin/sshd
