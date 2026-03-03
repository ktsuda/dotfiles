#!/usr/bin/env bash

case ${OSTYPE} in
    darwin*)
        if type gls &> /dev/null; then
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
            alias f='${EDITOR} $(fd -t f -t l | eval "$(__fzfcmd)")'
        fi
        ;;
    linux*)
        alias ls='ls -X -F -C -T 2 --color=auto'
        alias la='ls -a'
        alias ll='ls -lrt'
        alias lla='ll -a'

        if type fdfind &> /dev/null; then
            alias fd='fdfind --hidden --exclude .git'
            alias f='${EDITOR} $(fd -t f -t l | eval "$(__fzfcmd)")'
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

if type rg &> /dev/null; then
    alias rg='rg -H --column -n -S --no-heading --hidden --no-binary'
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

if type tig &> /dev/null; then
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

if type lazygit &> /dev/null; then
    alias l='lazygit'
fi

alias v="\${EDITOR}"

if type nvim &> /dev/null; then
    alias vimdiff='nvim -d'
fi

alias rmhist='history -c && rm -f ~/.bash_history && exit'

alias q='goto_repo_root'
function goto_repo_root() {
    if git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
        cd "$(git rev-parse --show-toplevel)" || return 0
    fi
}

alias ..='chdir_parent'
function chdir_parent {
    builtin cd .. || return 0
}

function __fzfcmd() {
    [ -n "$TMUX_PANE" ] \
        && { [ "${FZF_TMUX:-0}" != 0 ] || [ -n "$FZF_TMUX_OPTS" ]; } \
        && echo "fzf-tmux ${FZF_TMUX_OPTS:--d${FZF_TMUX_HEIGHT:-60%}} -- " \
        || echo "fzf"
}

alias r='git_repo_cd'
function git_repo_cd {
    local selected_dir ret

    selected_dir=$(ghq list --full-path | eval "$(__fzfcmd)")
    ret=$?
    ((ret == 0)) || return 0
    [[ -z $selected_dir ]] && return 0
    builtin cd -- "${selected_dir}" || return 0
}

alias o='subdir_cd'
function subdir_cd {
    local selected_dir ret

    selected_dir=$(fd -t d | eval "$(__fzfcmd)")
    ret=$?
    ((ret == 0)) || return 0
    [[ -z $selected_dir ]] && return 0
    builtin cd -- "${selected_dir}" || return 0
}

alias f='git_file_open'
function git_file_open() {
    local selected_file ret
    selected_file=$(git ls-files | eval "$(__fzfcmd)")
    ret=$?
    ((ret == 0)) || return 0
    [[ -z $selected_file ]] && return 0
    ${EDITOR} "${selected_file}"
}

alias ipv4='ipv4_address'
function ipv4_address() {
    local ipv4_address
    ipv4_address=$(ifconfig \
        | awk '$0 ~ /inet [0-9]+.[0-9]+.[0-9]+.[0-9]+/{ print $2 }' \
        | eval "$(__fzfcmd)") || return
    [[ -z $ipv4_address ]] && return 0
    echo "$ipv4_address"
}

alias sp='pkg_search'
function pkg_search() {
    local selected_pkg ret

    case ${OSTYPE} in
        linux*)
            selected_pkg=$(dpkg -l \
                | awk '/^ii/ { print $2 }' | eval "$(__fzfcmd)")
            ret=$?
            if [ -z "${selected_pkg}" ]; then
                return 0
            fi
            apt-cache depends "${selected_pkg}"
            echo
            apt-cache rdepends "${selected_pkg}"
            return $ret
            ;;
        darwin*)
            selected_formula=$(brew list -1 | eval "$(__fzfcmd)")
            ret=$?
            if [ -z "$selected_formula" ]; then
                return 0
            fi
            echo "${selected_formula} depends on..."
            brew deps "${selected_formula}" 2> /dev/null
            echo
            echo "${selected_formula} is used by..."
            brew uses --recursive "${selected_formula}" 2> /dev/null
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
        ID=$(tmux list-sessions 2> /dev/null | eval "$(__fzfcmd) -0" | cut -d: -f1)
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
    ID=$(tmux list-sessions 2> /dev/null | eval "$(__fzfcmd) -0" | cut -d: -f1)
    if [[ -z $ID ]]; then
        tmux new-session -s "default" tmux new-window -t "default" "$*"
        return
    fi
    tmux new-window -t "$ID" "$*"
}

if type tmux > /dev/null 2>&1; then
    alias s='custom_tmux_session'
    alias sa='custom_send_to_session'
fi
