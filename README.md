# dotfiles

## Requirements

### darwin

```bash
brew install stow rust golang ghostty vim git tig fzf tmux zsh
cargo install ripgrep fd-find
```

### linux

```bash
apt install -y curl stow golang vim git tig fzf
snap install ghostty
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
cargo install ripgrep fd-find
```

## Shared

### linux

```bash
apt install -y bash
```

## Private

### darwin

```bash
brew install nvim lazygit
cargo install tree-sitter-cli
```

### linux

```bash
apt install -y nvim xmonad rofi nitrogen zsh
cargo install tree-sitter-cli
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
