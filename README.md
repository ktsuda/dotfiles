# dotfiles

## Requirements

- stow (apt, brew)
- rust (rustup, brew)
- go (script, brew) 

### common

- git (apt, brew)
- tmux (apt, brew)
- ripgrep (cargo)
- fd-find (cargo)

### shared

- vim (apt, brew)

#### darwin

- zsh (brew)

#### linux

- bash (apt)

### private

- zsh (apt, brew)
- nvim (script, brew)
- lazygit (go)
- zathura (apt, brew)
- btop (apt, brew, cargo)
- tree-sitter-cli (cargo)

#### darwin

- iterm2 (brew)

#### linux

- alacritty (cargo)
- xmonad (apt)
- rofi (apt)
- nitrogen (apt)

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
