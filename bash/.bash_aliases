case ${OSTYPE} in
    darwin*)
        if type eza &> /dev/null; then
            alias ls='eza -F -g --color=auto'
            alias la='ls -a'
            alias ll='ls -l -s date --time-style long-iso --git'
            alias lla='ll -a'
        elif type exa &> /dev/null; then
            alias ls='exa -F -g --color=auto'
            alias la='ls -a'
            alias ll='ls -l -s date --time-style long-iso --git'
            alias lla='ll -a'
        elif type gls &> /dev/null; then
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

        if type fd &> /dev/null; then
            alias fd='fd --hidden --follow --exclude .git'
            alias f='${EDITOR} $(fd -t f -t l | $(__fzfcmd))'
        fi
        ;;
    linux*)
        if type eza &> /dev/null; then
            alias ls='eza -F -g --color=auto'
            alias la='ls -a'
            alias ll='ls -l -s date --time-style long-iso --git'
            alias lla='ll -a'
        elif type exa &> /dev/null; then
            alias ls='exa -F -g --color=auto'
            alias la='ls -a'
            alias ll='ls -l -s date --time-style long-iso --git'
            alias lla='ll -a'
        else
            alias ls='ls -X -F -C -T 2 --color=auto'
            alias la='ls -a'
            alias ll='ls -lrt'
            alias lla='ll -a'
        fi

        if type fdfind &> /dev/null; then
            alias fd='fdfind --hidden --exclude .git'
            alias f='${EDITOR} $(fd -t f -t l | $(__fzfcmd))'
        fi
        ;;
esac

if type fzf &> /dev/null; then
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
      ## tokyonight
      # export FZF_DEFAULT_OPTS=" ${FZF_DEFAULT_OPTS} \
      #   --color=bg+:#2e3c64,bg:#1f2335,border:#29a4bd,fg:#c0caf5 \
      #   --color=gutter:#1f2335,header:#ff9e64,hl+:#2ac3de,hl:#2ac3de \
      #   --color=info:#545c7e,marker:#ff007c,pointer:#ff007c,prompt:#2ac3de \
      #   --color=query:#c0caf5:regular,scrollbar:#29a4bd,separator:#ff9e64 \
      #   --color=spinner:#ff007c \
      #   "
      ## neosolarized
      export FZF_DEFAULT_OPTS=" ${FZF_DEFAULT_OPTS} \
        --color=bg+:#073642,bg:#002b36,spinner:#719e07,hl:#586e75 \
        --color=fg:#839496,header:#586e75,info:#cb4b16,pointer:#719e07 \
        --color=marker:#719e07,fg+:#839496,prompt:#719e07,hl+:#719e07 \
        "
    fi
    export FZF_DEFAULT_COMMAND="fd --type f --strip-cwd-prefix --hidden \
        --follow --exclude .git"
fi

if type bat &> /dev/null; then
    alias cat='bat --color=always --theme="Solarized (dark)"'
fi

if type rg &> /dev/null; then
    alias rg='rg -H --column -n -S --no-heading --hidden --no-binary'
fi

if type dust &> /dev/null; then
    alias du='dust -X .git'
fi

if type xh &> /dev/null; then
    alias wget='xh --download'
fi

if type duf &> /dev/null; then
    alias df='duf'
fi

if type taskell &> /dev/null; then
    alias task='taskell ~/taskell.md'
fi

if type pbcopy &> /dev/null; then
    :
elif type xclip &> /dev/null; then
    alias pbcopy='xclip -selection c'
elif type xsel &> /dev/null; then
    alias pbcopy='xsel --clipboard --input'
else
    echo 'Install xclip or xsel'
fi

alias rm='rm -i'
alias cp='cp -ip'
alias mv='mv -i'

alias gl='git l'
alias gb='git branch -av'
alias gs='git status -sb'
alias gd='git diff'
alias ga='git add -N . && git add -p'
alias gc='git commit -v'
alias gco='git checkout'
alias gp='git push origin'
alias gfp='git fetch -p'

alias dp='docker container ls'
alias di='docker image ls'
alias dv='docker volume ls'
alias dn='docker network ls'
alias drmp='docker rm $(dp -q -f "status=exited")'
alias drmi='docker rmi $(di -q -f "dangling=true")'

alias t='tig'
alias ta='tig --all'
alias ts='tig status'
alias tx='tmuxinator'

alias r='ranger'

alias v='nvim'
alias vim='nvim'
alias vc='nvim --clean'
alias vimc='nvim --clean'
alias vimdiff='nvim -d'
alias m='v $HOME/memo.md'

alias q='goto_repo_root'
function goto_repo_root() {
    if git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
        cd $(git rev-parse --show-toplevel)
    fi
}

function __fzfcmd() {
    [ -n "$TMUX_PANE" ] \
        && { [ "${FZF_TMUX:-0}" != 0 ] || [ -n "$FZF_TMUX_OPTS" ]; } \
        && echo "fzf-tmux ${FZF_TMUX_OPTS:--d${FZF_TMUX_HEIGHT:-60%}} -- " \
        || echo "fzf"
}

alias gr='git_repo_cd'
function git_repo_cd() {
    local selected_dir=$(ghq list --full-path | $(__fzfcmd))
    local ret=$?
    if [ -z "$selected_dir" ]; then
        return 0
    fi
    eval "builtin cd -- ${selected_dir}"
    return $ret
}

alias ipv4='ipv4_address'
function ipv4_address() {
    local ipv4_address=$(ifconfig \
        | awk '$0 ~ /inet [0-9]+.[0-9]+.[0-9]+.[0-9]+/{ print $2 }' \
        | $(__fzfcmd))
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
            local selected_pkg=$(dpkg -l \
                | awk '/^ii/ { print $2 }' | $(__fzfcmd))
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
            brew deps $selected_formula 2> /dev/null
            echo
            echo "${selected_formula} is used by..."
            brew uses --recursive $selected_formula 2> /dev/null
            echo
            return $ret
            ;;
    esac
}

function custom_tmux_session() {
    if [[ $# -ge 1 ]]; then
        ID="$1"
        if [[ -n $TMUX ]]; then
            tmux new-session -d -s"$ID"
            tmux switch-client -t "$ID"
        else
            tmux new-session -s"$ID"
        fi
    else
        ID=$(tmux list-sessions 2> /dev/null | $(__fzfcmd) -0 | cut -d: -f1)
        if [[ -z $ID ]]; then
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

function custom_send_to_session() {
    if [[ $# -lt 1 ]]; then
        return
    fi
    ID=$(tmux list-sessions 2> /dev/null | $(__fzfcmd) -0 | cut -d: -f1)
    if [[ -z $ID ]]; then
        tmux new-session -s "default" tmux new-window -t "default" "$*"
        return
    fi
    tmux new-window -t "$ID" "$*"
}

if type tmux > /dev/null 2>&1; then
    alias s='custom_tmux_session'
    alias a='custom_send_to_session'
elif type screen > /dev/null 2>&1; then
    alias s='screen'
else
    :
fi
