# dotfiles

## Requirements

### darwin

```bash
brew install stow rust golang
brew install ghostty tmux herdr fzf zsh
brew install nvim git lazygit btop
cargo install ripgrep fd-find tree-sitter-cli
```

### linux

```bash
apt install -y curl vim zsh clang
snap install ghostty --classic
snap install btop

./install-term
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

### darwin

```bash
brew install crix
```

### linux

```bash
apt install -y xmonad rofi nitrogen
```

## Install dotfiles

### Install stow

```bash
apt install -y build-essential perl texinfo
```

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
./update -s # for shared host
./update -p # for private host
```

## Delete dotfiles

```bash
cd dotfiles
./update -D
```
