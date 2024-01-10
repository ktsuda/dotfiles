# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
    *) return ;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color | *-256color)
        color_prompt=yes
        ;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # We have color support; assume it's compliant with Ecma-48
        # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
        # a case would tend to support setf rather than setaf.)
        color_prompt=yes
    else
        color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
    xterm* | rxvt*)
        PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
        ;;
    *) ;;
esac

# language environment
case ${OSTYPE} in
    darwin*)
        export LC_ALL=en_US.UTF-8
        export LANG=en_US.UTF-8
        ;;
    linux*)
        export LC_ALL=en_US.utf8
        export LANG=en_US.utf8
        export LANGUAGE=en_US.utf8
        ;;
esac

# homebrew
case ${OSTYPE} in
    darwin*)
        eval "$(/opt/homebrew/bin/brew shellenv)"
        ;;
esac

# set PATH so it includes user's private bin if it exists
[ -d "$HOME/.fzf/bin" ] && PATH="$HOME/.fzf/bin:$PATH"
[ -d "$HOME/bin" ] && PATH="$HOME/bin:$PATH"
[ -d "$HOME/.rbenv/bin" ] && PATH="$HOME/.rbenv/bin:$PATH"
[ -d "$HOME/.local/share/nvim/mason/bin" ] && PATH="$HOME/.local/nvim/mason/bin:$PATH"
[ -d "$HOME/go/bin" ] && PATH="$HOME/go/bin:$PATH"
[ -d "/usr/local/go/bin" ] && PATH="/usr/local/go/bin:$PATH"
[ -d "$HOME/.cargo/bin" ] && PATH="$HOME/.cargo/bin:$PATH"
[ -d "$HOME/.local/bin" ] && PATH="$HOME/.local/bin:$PATH"
[ -d "$HOME/.yarn/bin" ] && PATH="$HOME/.yarn/bin:$PATH"
[ -d "$HOME/Library/Python/3.9/bin" ] && PATH="$HOME/Library/Python/3.9/bin:$PATH"
[ -d "$HOME/.config/yarn/global/node_modules/bin" ] && PATH="$HOME/.config/yarn/global/node_modules/bin:$PATH"
[ -d "$HOME/.deno/bin" ] && PATH="$HOME/.deno/bin:$PATH"
[ -d "/usr/local/bin" ] && PATH="/usr/local/bin:$PATH"
[ -d "/usr/local/lib/nodejs/bin" ] && PATH="/usr/local/lib/nodejs/bin:$PATH"
[ -d "/usr/bin" ] && PATH="/usr/bin:$PATH"
[ -d "/usr/sbin" ] && PATH="/usr/sbin:$PATH"
[ -d "/bin" ] && PATH="/bin:$PATH"
[ -d "/sbin" ] && PATH="/sbin:$PATH"
[ -d "/usr/local/sbin" ] && PATH="/usr/local/sbin:$PATH"
[ -d "/opt/local/bin" ] && PATH="/opt/local/bin:$PATH"
[ -d "/Library/Apple/usr/bin" ] && PATH="/Library/Apple/usr/bin:$PATH"

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi

# zoxide
if type zoxide &> /dev/null; then
    eval "$(zoxide init bash)"
fi

# rbenv
[ -x "$HOME/.rbenv/bin/rbenv" ] && eval "$($HOME/.rbenv/bin/rbenv init - bash)"

# gopath
[ -d "$HOME/go" ] && export GOPATH="$HOME/go"
[ -d "$HOME/go/bin" ] && export GOBIN="$HOME/go/bin"
export GO11MODULE="auto"

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

[ -f "$HOME/.bash_aliases" ] && . $HOME/.bash_aliases
