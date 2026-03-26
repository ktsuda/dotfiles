bindkey -e

umask 022

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

# prevent zsh from exit with ctrl-d key
setopt IGNOREEOF
# share history, avoid duplication
setopt share_history
setopt hist_reduce_blanks
setopt hist_ignore_all_dups
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups

# disable lock/unlock with ctrl-s/ctrl-q
setopt no_flow_control

typeset -U path PATH

path=(
  ~/.fzf/bin(N-/)
  ~/bin(N-/)
  ~/.rbenv/bin(N-/)
  ~/.local/share/nvim/mason/bin(N-/)
  ~/go/bin(N-/)
  /usr/local/go/bin(N-/)
  ~/.cargo/bin(N-/)
  ~/.local/bin(N-/)
  ~/.yarn/bin(N-/)
  ~/Library/Python/3.9/bin(N-/)
  ~/.config/yarn/global/node_modules/bin(N-/)
  ~/.deno/bin(N-/)
  /bin
  /sbin
  /usr/bin
  /usr/sbin
  /usr/local/bin(N-/)
  /usr/local/sbin(N-/)
  /usr/local/lib/nodejs/bin(N-/)
  /opt/local/bin(N-/)
  /Library/Apple/usr/bin(N-/)
  /home/linuxbrew/.linuxbrew/bin(N-/)
  $path
)

case ${OSTYPE} in
  linux*)
    test -d /home/linuxbrew/.linuxbrew && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    ;;
  darwin*)
    eval "$(/opt/homebrew/bin/brew shellenv)"
    ;;
esac

case ${OSTYPE} in
  linux*)
    if ! pgrep -u "$USER" ssh-agent > /dev/null; then
      ssh-agent -s > ~/.ssh/ssh-agent-env
    fi
    if [ -f ~/.ssh/ssh-agent-env ]; then
      . ~/.ssh/ssh-agent-env > /dev/null
      ssh-add > /dev/null 2>&1
    fi
    ;;
esac

typeset -U fpath

if (( $+commands[brew] )); then
  fpath=(
    $(brew --prefix)/share/zsh-completions(N-/)
    $(brew --prefix)/share/zsh/site-functions(N-/)
    $(brew --prefix)/share/zsh-syntax-highlighting(N-/)
    $fpath
  )
  if [ -f "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]; then
    source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
  fi
fi

fpath=(
  ~/.config/zsh/zsh-completions(N-/)
  $fpath
)

# git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
if [ -f "$HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh" ]; then
  source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

autoload -Uz compinit; compinit

# Set the default editor
if (( $+commands[nvim] )); then
  EDITOR='nvim'
elif (( $+commands[vim] )); then
  EDITOR='vim'
elif (( $+commands[vi] )); then
  EDITOR='vi'
else
  EDITOR='nano'
fi

export VISUAL=${EDITOR}
export EDITOR

# 1Password
function _op() {
  unfunction "$0"
  eval "$(op completion zsh)"
  $0 "$@"
}
compdef _op op

# fzf fuzzy completion
function _fzf() {
  unfunction "$0"
  FZF_CTRL_R_COMMAND= FZF_ALT_C_COMMAND= source <($HOME/.fzf/bin/fzf --zsh)
  $0 "$@"
}
compdef _fzf fzf

# Ruby
function _rbenv() {
  unfunction "$0"
  eval "$($HOME/.rbenv/bin/rbenv init - zsh)"
  $0 "$@"
}
compdef _rbenv rbenv

# Python
function _uv() {
  unfunction "$0"
  eval "$(uv generate-shell-completion zsh)"
  $0 "$@"
}
compdef _uv uv

# direnv
if (( $+commands[direnv] )); then
  eval "$(direnv hook zsh)"
fi

# zoxide
if (( $+commands[zoxide] )); then
  eval "$(zoxide init --cmd cd zsh)"
fi

# golang
export GOPATH="$HOME/go"
export GOBIN="$HOME/go/bin"
export GO11MODULE="auto"

export WAKATIME_HOME="$HOME/.wakatime_home"

# prompt
PROMPT='%n@%m:%~ $ '
autoload -Uz vcs_info
function precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
RPROMPT=\$vcs_info_msg_0_
zstyle ':vcs_info:git:*' formats '%b'

# aliases
case ${OSTYPE} in
  darwin*)
    if (( $+commands[gls] )); then
      alias ls='gls -X -F -C -T 2 --color=auto'
      alias la='ls -a'
      alias ll='ls -lrt'
      alias lla='ll -a'
    else
      alias ls='ls -F -C -G'
      alias la='ls -a'
      alias ll='ls -lrt'
      alias lla='ll -a'
    fi

    if (( $+commands[fd] )); then
      alias fd='fd --hidden --follow --exclude .git'
      alias f='${EDITOR} $(fd -t f -t l | $(__fzfcmd))'
    fi
    ;;
  linux*)
    alias ls='ls -X -F -C -T 2 --color=auto'
    alias la='ls -a'
    alias ll='ls -lrt'
    alias lla='ll -a'

    if (( $+commands[fd] )); then
      alias fd='fd --hidden --follow --exclude .git'
      alias f='${EDITOR} $(fd -t f -t l | $(__fzfcmd))'
    elif (( $+commands[fdfind] )); then
      alias fd='fdfind --hidden --exclude .git'
      alias f='${EDITOR} $(fd -t f -t l | $(__fzfcmd))'
    fi
    ;;
esac

if (( $+commands[fzf] )); then
  if [ -z "$FZF_DEFAULT_OPTS" ]; then
    FZF_DEFAULT_OPTS="\
      --highlight-line \
      --info=inline-right \
      --ansi \
      --layout=reverse \
      --border=none \
      --height 60% \
      --no-multi \
      "

    ## catppuccin
    export FZF_DEFAULT_OPTS=" ${FZF_DEFAULT_OPTS} \
      --color=bg+:#313244,bg:#1E1E2E,spinner:#F5E0DC,hl:#F38BA8 \
      --color=fg:#CDD6F4,header:#F38BA8,info:#CBA6F7,pointer:#F5E0DC \
      --color=marker:#B4BEFE,fg+:#CDD6F4,prompt:#CBA6F7,hl+:#F38BA8 \
      --color=selected-bg:#45475A \
      --color=border:#6C7086,label:#CDD6F4 \
      "
  fi

  export FZF_DEFAULT_COMMAND="fd --type f --strip-cwd-prefix --hidden \
    --follow --exclude .git"
fi

if (( $+commands[rg] )); then
  alias rg='rg -H --column -n -S --no-heading --hidden --no-binary'
fi

if (( $+commands[pbcopy] )); then
  :
elif (( $+commands[xclip] )); then
  alias pbcopy='xclip -selection c'
elif (( $+commands[xsel] )); then
  alias pbcopy='xsel --clipboard --input'
else
  echo 'Install xclip or xsel'
fi

if (( $+commands[tig] )); then
  alias t='tig'
  alias ta='tig --all'
fi

alias rm='rm -i'
alias cp='cp -ip'
alias mv='mv -i'

alias gl='git l'
alias gla='git l --all'
alias gb='git branch -av'
alias gs='git status -sb'
alias gd='git diff'
alias ga='git add -N . && git add -p'
alias gc='git commit -v'
alias gco='git checkout'
alias gp='git push origin'
alias gfp='git fetch -p'
alias grc='git rebase --continue'

alias drmp='docker rm $(docker ps -q -f "status=exited")'
alias drmi='docker rmi $(docker images -q -f "dangling=true")'

if (( $+commands[lazygit] )); then
  alias l='lazygit'
fi

alias v="${EDITOR}"

if (( $+commands[nvim] )); then
  alias vimdiff='nvim -d'
fi

alias rmhist='history -p && rm -f ~/.zsh_history && exit'

alias q='goto_repo_root'
function goto_repo_root() {
  if git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
    cd "$(git rev-parse --show-toplevel)"
  fi
}

function chdir_parent() {
  echo
  cd ..
  zle accept-line
}
zle -N chdir_parent
bindkey '^u' chdir_parent

function __fzfcmd() {
  [ -n "$TMUX_PANE" ] \
    && { [ "${FZF_TMUX:-0}" != 0 ] || [ -n "$FZF_TMUX_OPTS" ]; } \
    && echo "fzf-tmux ${FZF_TMUX_OPTS:--d${FZF_TMUX_HEIGHT:-60%}} -- " \
    || echo "fzf"
}

function git_repo_cd() {
  local selected_dir=$(ghq list --full-path | $(__fzfcmd))
  local ret=$?
  if [ -z "$selected_dir" ]; then
    zle redisplay
    return 0
  fi
  eval 'builtin cd -- "${selected_dir}"'
  zle reset-prompt > /dev/null 2>&1 || true
  return $ret
}
zle -N git_repo_cd
bindkey "^s" git_repo_cd

function subdir_cd() {
  local selected_dir
  if (( $+commands[fd] )); then
    local selected_dir=$(fd -t d | $(__fzfcmd))
  else
    local selected_dir=$(find . -type d | $(__fzfcmd))
  fi
  local ret=$?
  if [ -z "$selected_dir" ]; then
    zle redisplay
    return 0
  fi
  eval 'builtin cd -- "${selected_dir}"'
  zle reset-prompt > /dev/null 2>&1 || true
  return $ret
}
zle -N subdir_cd
bindkey "^o" subdir_cd

function history_widget() {
  local selected num
  selected=($(fc -rl 1 | $(__fzfcmd)))
  local ret=$?
  if [ -n "$selected" ]; then
    num=$selected[1]
    if [ -n "$num" ]; then
      zle vi-fetch-history -n $num
    fi
  fi
  zle reset-prompt > /dev/null 2>&1 || true
  return $ret
}
zle -N history_widget
bindkey "^r" history_widget

alias ipv4='ipv4_address'
function ipv4_address() {
  local ipv4_address=$(ifconfig | \
    awk '$0 ~ /inet [0-9]+.[0-9]+.[0-9]+.[0-9]+/{ print $2 }' | $(__fzfcmd))
  local ret=$?
  if [ -z "$ipv4_address" ]; then
    return 0
  fi
  echo "$ipv4_address"
  return $ret
}

alias sp='pkg_search'
function pkg_search() {
  case ${OSTYPE} in
    linux*)
      local selected_pkg=$(dpkg -l | \
        awk '/^ii/ { print $2 }' | $(__fzfcmd))
      local ret=$?
      if [ -z "$selected_pkg" ]; then
        return 0
      fi
      apt-cache depends $selected_pkg
      echo
      apt-cache rdepends $selected_pkg
      return $ret
      ;;
    darwin*)
      local selected_formula=$(brew list -1 | $(__fzfcmd))
      local ret=$?
      if [ -z "$selected_formula" ]; then
        return 0
      fi
      echo "${selected_formula} depends on..."
      brew deps $selected_formula 2>/dev/null
      echo
      echo "${selected_formula} is used by..."
      brew uses --eval-all $selected_formula 2>/dev/null
      echo
      return $ret
      ;;
  esac
}

function custom_tmux_session() {
  exec </dev/tty
  exec <&1
  local session
  if [[ $# -ge 1 ]]; then
    session="$1"
    if [[ -n $TMUX ]]; then
      tmux new-session -d -s"$session"
      tmux switch-client -t "$session"
    else
      tmux new-session -s"$session"
    fi
  else
    session=$(tmux list-sessions 2>/dev/null | $(__fzfcmd) -0 | cut -d: -f1)
    if [[ -z "$session" ]]; then
      tmux new-session -s "default"
      return
    fi
    if [[ -n $TMUX ]]; then
      tmux switch-client -t "$session"
    else
      tmux attach-session -t "$session"
    fi
  fi
}

function custom_tmux_send_to() {
  exec </dev/tty
  exec <&1
  if [[ $# -lt 1 ]]; then
    echo "Usage: sa <command>"
    return
  fi
  local session
  session=$(tmux list-sessions 2>/dev/null | $(__fzfcmd) -0 | cut -d: -f1)
  if [[ -z "$session" ]]; then
    tmux new-session -s "default" tmux new-window -t "default" "$*"
    return
  fi
  tmux new-window -t "$session" "$*"
}

function sesh_sessions() {
  exec </dev/tty
  exec <&1
  local session
  session=$(sesh list --icons | $(__fzfcmd) \
    --no-sort --ansi \
    --bind 'ctrl-d:execute(tmux kill-session -t {2..})+reload(sesh list --icons)' \
    --preview-window 'right:55%:noborder' \
    --preview 'sesh preview {}'
  )
  zle reset-prompt > /dev/null 2>&1 || true
  [[ -z "$session" ]] && return
  sesh connect $session
}

function custom_sesh_send_to() {
  exec </dev/tty
  exec <&1
  if [[ $# -lt 1 ]]; then
    echo "Usage: sa <command>"
    return
  fi
  local session
  session=$(sesh list -t --icons | $(__fzfcmd) \
    --no-sort --ansi \
    --preview-window 'right:55%:noborder' \
    --preview 'sesh preview {}'
  )
  zle reset-prompt > /dev/null 2>&1 || true
  if [[ -z "$session" ]]; then
    sesh connect --command "$*" "default"
    return
  fi
  tmux new-window -t "$ID" "$*"
}

if (( $+commands[tmux] )); then
  if (( $+commands[sesh] )); then
    alias s='sesh_sessions'
    alias sa='custom_sesh_send_to'
  else
    alias s='custom_tmux_session'
    alias sa='custom_tmux_send_to'
  fi
fi

case ${OSTYPE} in
  linux*)
    export CPLUS_INCLUDE_PATH=/usr/include/c++/11:/usr/include/x86_64-linux-gnu/c++/11
    ;;
esac

if [ ! -f ~/.zshrc.zwc -o ~/.zshrc -nt ~/.zshrc.zwc ]; then
  zcompile ~/.zshrc
fi
