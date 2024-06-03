# dotfiles

## Requirements

### macos

- homebrew
- stow
- zsh
- tmux
- git
- gh
- tig
- nvim

### macos (private)

In addition to macos packages,

- alacritty
- bat
- wakatime
- taskell
- zathura

### linux

- stow
- bash
- tmux
- git
- github
- tig
- nvim

## linux (private)

In addition to linux packages,

- foot
- bat
- wakatime
- taskell
- zathura
- sway

## Install dotfiles

For linux (private),

```bash
git clone https://github.com/ktsuda/dotfiles.git
cd dotfiles
./update -U --private-linux
```

## Delete dotfiles

```bash
cd dotfiles
./update -D
```

## ToDo

- Add a script to install dotfiles that does not require the repository itself
