# dotfiles

## Requirements

### common

- stow
- zsh
- ripgrep
- tmux
- git
- tig
- nvim
- bat
- wakatime
- zathura
- w3m
- eza

### macos only

- homebrew
- iterm2

### linux

- alacritty
- i3
- wofi

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

## ToDo

- Add a script to install dotfiles that does not require the repository itself
