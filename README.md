# dotfiles

## Requirements

### darwin

```bash
brew install stow rust golang ghostty vim git tig fzf tmux zsh nvim lazygit lazyjj btop
cargo install ripgrep fd-find tree-sitter-cli zoxide du-dust alacritty
```

### linux

```bash
apt install -y curl vim tmux zsh clang
snap install ghostty --classic
snap install btop

./install-git
./install-fzf
./install-golang
./install-rust
./install-neovim
./install-nodejs
./install-fonts

chsh -s /usr/bin/zsh "$USER"
```

## Private

### linux

```bash
apt install -y xmonad rofi nitrogen
```

## Install dotfiles

### Install stow

apt install -y build-essential perl texinfo

```bash
git clone --branch v2.4.1 https://github.com/aspiers/stow
cd stow
autoreconf -iv
./configure && make
sudo make install
```

### symlink dotfiles

```bash
git clone https://github.com/ktsuda/dotfiles.git
cd dotfiles
./update -c # for console
./update -s # for shared host
./update -p # for private host
```

## Delete dotfiles

```bash
cd dotfiles
./update -D
```
