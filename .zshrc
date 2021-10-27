# vim: set ts=2 sw=2 sts=2 et
bindkey -e

# prevent zsh from exit with ctrl-d key
setopt IGNOREEOF
# share history, avoid duplication
setopt share_history
setopt hist_reduce_blanks
setopt hist_ignore_all_dups
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

# cd only with dirname
setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups

# disable lock/unlock with ctrl-s/ctrl-q
setopt no_flow_control

# completion
if type brew &>/dev/null; then
  fpath=(/opt/homebrew/share/zsh-completions $fpath)
fi

typeset -U fpath

autoload -Uz compinit; compinit

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
setopt list_packed

# color
autoload -Uz colors; colors
zstyle ':completion:*' list-colors ''

# env variables
[[ -d "/opt/local/bin" ]] && PATH="/opt/local/bin:$PATH"
[[ -d "/usr/local/sbin" ]] && PATH="/usr/local/sbin:$PATH"
[[ -d "$HOME/bin" ]] && PATH="$HOME/bin:$PATH"
[[ -d "/usr/local/go/bin" ]] && PATH="/usr/local/go/bin:$PATH"
[[ -d "$HOME/.ghq" ]] && GOPATH="$HOME/.ghq"
[[ -d "$HOME/.ghq/src" ]] && GHQ_ROOT="$HOME/.ghq/src"
[[ -d "$HOME/.ghq/bin" ]] && PATH="$HOME/.ghq/bin:$PATH"
[[ -d "$HOME/.cargo/bin" ]] && PATH="$HOME/.cargo/bin:$PATH"
[[ -d "$HOME/.fzf/bin" ]] && PATH="$HOME/.fzf/bin:$PATH"
[[ -d "$HOME/.screen" ]] && SCREENDIR=$HOME/.screen
[[ -d "/opt/matlab/R2020a/bin" ]] && PATH="/opt/matlab/R2020a/bin:$PATH"
[[ -d "$HOME/.gem/ruby/2.6.0/bin" ]] && PATH="$HOME/.gem/ruby/2.6.0/bin:$PATH"
[[ -d "/opt/homebrew/opt/llvm/bin" ]] && PATH="/opt/homebrew/opt/llvm/bin:$PATH"
[[ -d "/opt/homebrew/sbin" ]] && PATH="/opt/homebrew/sbin:$PATH"
[[ -d "/opt/homebrew/bin" ]] && PATH="/opt/homebrew/bin:$PATH"

typeset -U path

export EDITOR
export GOPATH
export GHQ_ROOT
export SCREENDIR

export GOBIN="$HOME/bin"
export GO111MODULE="auto"

if type vim > /dev/null 2>&1; then
  EDITOR=vim
else
  EDITOR=nano
fi

if type exa > /dev/null 2>&1; then
  alias ls='exa -F --no-icons'
  alias ll='ls -l'
  alias la='ls -a'
  alias lla='ll -a'
else
  alias ls='/bin/ls -F'
  alias ll='ls -l'
  alias la='ls -A'
  alias lla='ll -A'
fi

alias rm='rm -i'
alias cp='cp -ip'
alias mv='mv -i'
alias g='git'
alias gfp='g fetch -p'
alias ga='g a'
alias gs='g status -sb'
alias gb='g branch -av'
alias t='tig'
alias ta='tig --all'
alias ag='rg'
alias v='vim'
alias vimdiff='nvim -d'

alias q='goto_repo_root'
function goto_repo_root() {
  if git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
    cd $(git rev-parse --show-toplevel)
  fi
}

function chdir_parent() {
  echo
  cd ..
  zle accept-line
}
zle -N chdir_parent
bindkey '^u' chdir_parent

function git-repo-cd() {
  local selected_dir=$(ghq list --full-path | fzf-tmux --query "$LBUFFER")
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
}
zle -N git-repo-cd
bindkey "^s" git-repo-cd

PROMPT="%(?.%{${fg[green]}%}.%{${fg[red]}%})%n${reset_color}@${fg[cyan]}%m${reset_color}(%*%) %~
%# "

RPROMPT="[%~]"
autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{yellow}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{red}+"
zstyle ':vcs_info:*' formats "%F{green}%c%u[%b]%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd () { vcs_info }
RPROMPT=$RPROMPT'${vcs_info_msg_0_}'

function custom_tmux_session() {
  if [[ ! -n $TMUX && $- == *l* ]]; then
    ID="`tmux list-sessions`"
    if [[ -z "$ID" ]]; then
      tmux new-session
    fi
    create_new_session="Create a new session"
    ID="$ID\n${create_new_session}:"
    ID="`echo $ID | fzf | cut -d: -f1`"
    if [[ "$ID" = "${create_new_session}" ]]; then
      tmux new-session
    elif [[ -n "$ID" ]]; then
      tmux attach-session -t "$ID"
    else
      :
    fi
  fi
}

if type tmux > /dev/null 2>&1; then
  alias s='custom_tmux_session'
elif type screen > /dev/null 2>&1; then
  alias s='screen'
else
  ;
fi

if [ ! -f ~/.zshrc.zwc -o ~/.zshrc -nt ~/.zshrc.zwc ]; then
  zcompile ~/.zshrc
fi
