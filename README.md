# dotfiles-minimal

## Requirements

- homebrew
- stow
- git
- iterm2
- neovim
- tmux
- zsh

## Install dotfiles

```bash
git clone https://github.com/ktsuda/dotfiles-minimal
cd dotfiles-minimal
./update -U --macos
```

## Delete dotfiles

```bash
cd dotfiles-minimal
./update -D
```

## ToDo

- Support other operating systems
- Add a script to install dotfiles that does not require the repository itself
- Get rid of the configurations which are specific to the author
