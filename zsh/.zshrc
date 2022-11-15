bindkey -e

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

EDITOR=nvim

setopt auto_pushd
setopt pushd_ignore_dups

# disable lock/unlock with ctrl-s/ctrl-q
setopt no_flow_control

typeset -U path PATH

case ${OSTYPE} in
  darwin*)
    eval "$(/opt/homebrew/bin/brew shellenv)"
    ;;
esac

path=(
  ~/.ghq/bin(N-/)
  ~/bin(N-/)
  /usr/local/go/bin(N-/)
  ~/.cargo/bin(N-/)
  ~/.local/bin(N-/)
  ~/.yarn/bin(N-/)
  ~/Library/Python/3.9/bin(N-/)
  ~/.config/yarn/global/node_modules/bin(N-/)
  /usr/local/bin(N-/)
  /usr/bin
  /usr/sbin
  /bin
  /sbin
  /usr/local/sbin(N-/)
  /opt/local/bin(N-/)
  /Library/Apple/usr/bin(N-/)
  $path
)

typeset -U fpath

fpath=(
  /opt/homebrew/share/zsh-completions(N-/)
  ~/.config/zsh/zsh-completions(N-/)
  $fpath
)

case ${OSTYPE} in
  darwin*)
    source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    ;;
esac

autoload -Uz compinit; compinit

export GHQ_ROOT="$HOME/.ghq/src"
export GOPATH="$HOME/.ghq"
export GOBIN="$HOME/bin"
export GO11MODULE="auto"

PROMPT='%n@%m:%~$ '
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
RPROMPT=\$vcs_info_msg_0_
zstyle ':vcs_info:git:*' formats '%b'

if type gls &>/dev/null; then
  alias ls='gls -X -F -T 2 -C --color=auto'
else
  alias ls='ls -F -C -G'
fi

alias ll='ls -l'
alias la='ls -A'
alias lla='ll -A'

alias rm='rm -i'
alias cp='cp -ip'
alias mv='mv -i'

alias gs='git status -sb'
alias gc='git commit -s -v'
alias gl='git l'
alias ga='git add -N . && git add -p'

alias t='tig'
alias ta='tig --all'
alias ts='tig status'

alias v='nvim'
alias vim='nvim'
alias vc='nvim --clean'
alias vimc='nvim --clean'
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

export FZF_TMUX_OPTS="-p"
function __fzfcmd() {
  [ -n "$TMUX_PANE" ] && { [ "${FZF_TMUX:-0}" != 0 ] || [ -n "$FZF_TMUX_OPTS" ]; } &&
    echo "fzf-tmux ${FZF_TMUX_OPTS:--d${FZF_TMUX_HEIGHT:-40%}} -- " || echo "fzf"
}

function git-repo-cd() {
  local selected_dir=$(ghq list --full-path | $(__fzfcmd) --query "$LBUFFER")
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
}
zle -N git-repo-cd
bindkey "^s" git-repo-cd

function fssh() {
  local selected_host
  selected_host=$(cat ~/.ssh/config | grep -i ^host | awk '{print $2}' | $(__fzfcmd))
  if [ -n "$selected_dir" ]; then
    ssh ${selected_host}
  else
    return 1
  fi
 }

function custom_tmux_session() {
  if [[ "$#" -ge 1 ]]; then
    ID="$1"
    if [[ -n $TMUX ]]; then
      tmux new-session -d -s"$ID"
      tmux switch-client -t "$ID"
    else
      tmux new-session -s"$ID"
    fi
  else
    ID="`tmux list-sessions 2>/dev/null | $(__fzfcmd) -0 | cut -d: -f1`"
    if [[ -z "$ID" ]]; then
      tmux new-session -s "default"
      return
    fi
    if [[ -n $TMUX ]]; then
      tmux switch-client -t "$ID"
    else
      tmux attach-session -t "$ID"
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
