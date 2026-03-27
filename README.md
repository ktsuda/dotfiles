# dotfiles

## Requirements

### darwin

```bash
brew install stow rust golang ghostty vim git tig fzf tmux zsh nvim lazygit
cargo install ripgrep fd-find tree-sitter-cli
```

### linux

```bash
apt install -y curl stow vim tmux zsh clang
snap install ghostty --classic

./install-git
./install-fzf
./install-golang
./install-rust
./install-neovim
./install-nodejs
```

## Private

### linux

```bash
apt install -y xmonad rofi nitrogen
```

## Install dotfiles

### shared host

```bash
git clone https://github.com/ktsuda/dotfiles.git
cd dotfiles
./update -s
```

### private host

```bash
git clone https://github.com/ktsuda/dotfiles.git
cd dotfiles
./update -p
```

## Delete dotfiles

```bash
cd dotfiles
./update -D
```
