# dotfiles

## Requirements

### common

- stow
- bash
- zsh
- ripgrep
- tmux
- git
- tig
- nvim

### private

- ranger
- alacritty
- wakatime
- bat
- eza
- zathura
- w3m

#### macos only

- homebrew
- iterm2

#### linux

- xmonad
- rofi
- nitrogen
- btop

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

- Add a script that allows us to install dotfiles by downloading it
