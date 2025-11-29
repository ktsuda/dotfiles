# Fish Shell Configuration
# Converted from zsh configuration

# umask
umask 022

# Locale settings
switch (uname)
    case Darwin
        set -gx LC_ALL en_US.UTF-8
        set -gx LANG en_US.UTF-8
    case Linux
        set -gx LC_ALL en_US.utf8
        set -gx LANG en_US.utf8
        set -gx LANGUAGE en_US.utf8
end

# History configuration
# Fish handles history automatically, but we can configure it
set -g fish_history_max_size 10000

# Set the default editor
if type -q nvim
    set -gx EDITOR nvim
else if type -q vim
    set -gx EDITOR vim
else if type -q vi
    set -gx EDITOR vi
else
    set -gx EDITOR nano
end

set -gx VISUAL $EDITOR

# PATH configuration
# Fish uses fish_add_path to manage PATH (automatically deduplicates)
fish_add_path -g ~/.fzf/bin
fish_add_path -g ~/bin
fish_add_path -g ~/.rbenv/bin
fish_add_path -g ~/.local/share/nvim/mason/bin
fish_add_path -g ~/go/bin
fish_add_path -g /usr/local/go/bin
fish_add_path -g ~/.cargo/bin
fish_add_path -g ~/.local/bin
fish_add_path -g ~/.yarn/bin
fish_add_path -g ~/Library/Python/3.9/bin
fish_add_path -g ~/.config/yarn/global/node_modules/bin
fish_add_path -g ~/.deno/bin
fish_add_path -g /usr/local/bin
fish_add_path -g /usr/local/sbin
fish_add_path -g /usr/local/lib/nodejs/bin
fish_add_path -g /opt/local/bin
fish_add_path -g /Library/Apple/usr/bin

# Homebrew setup for macOS
if test (uname) = Darwin
    if test -f /opt/homebrew/bin/brew
        eval (/opt/homebrew/bin/brew shellenv)
    end
end

# SSH agent setup for Linux
if test (uname) = Linux
    if test -z (pgrep ssh-agent | string collect)
        ssh-agent -c >~/.ssh/ssh-agent-env.fish
        sed -i 's/setenv/set -Ux/g' ~/.ssh/ssh-agent-env.fish
    end
    if test -f ~/.ssh/ssh-agent-env.fish
        source ~/.ssh/ssh-agent-env.fish >/dev/null
        ssh-add >/dev/null 2>&1
    end
end

# Fish syntax highlighting (via fisher or similar)
# Install: fisher install jorgebucaran/fish-bax for zsh plugin compatibility

# zoxide initialization
if type -q zoxide
    zoxide init fish | source
end

# 1Password CLI completion
if type -q op
    op completion fish | source
end

# rbenv initialization
if test -x $HOME/.rbenv/bin/rbenv
    rbenv init - fish | source
end

# uv completion
if type -q uv
    uv generate-shell-completion fish | source
end

# Go environment variables
set -gx GOPATH $HOME/go
set -gx GOBIN $HOME/go/bin
set -gx GO11MODULE auto

# WakaTime home
set -gx WAKATIME_HOME $HOME/.wakatime_home

# Prompt configuration
# Fish uses fish_prompt function instead of PROMPT variable
# Git integration is handled by fish_git_prompt (built-in)

# ls aliases based on OS and available tools
switch (uname)
    case Darwin
        if type -q eza
            alias ls='eza -F -g --color=auto'
            alias la='ls -a'
            alias ll='ls -l -s date --time-style long-iso --git'
            alias lla='ll -a'
        else if type -q exa
            alias ls='exa -F -g --color=auto'
            alias la='ls -a'
            alias ll='ls -l -s date --time-style long-iso --git'
            alias lla='ll -a'
        else if type -q gls
            alias ls='gls -X -F -C -T 2 --color=auto'
            alias la='ls -a'
            alias ll='ls -lrt'
            alias lla='ll -a'
        else
            alias ls='ls -F -C -G'
            alias la='ls -a'
            alias ll='ls -lrt'
            alias lla='ll -a'
        end

        if type -q fd
            alias fd='fd --hidden --follow --exclude .git'
            alias f='$EDITOR (fd -t f -t l | __fzfcmd)'
        end

    case Linux
        if type -q eza
            alias ls='eza -F -g --color=auto'
            alias la='ls -a'
            alias ll='ls -l -s date --time-style long-iso --git'
            alias lla='ll -a'
        else if type -q exa
            alias ls='exa -F -g --color=auto'
            alias la='ls -a'
            alias ll='ls -l -s date --time-style long-iso --git'
            alias lla='ll -a'
        else
            alias ls='ls -X -F -C -T 2 --color=auto'
            alias la='ls -a'
            alias ll='ls -lrt'
            alias lla='ll -a'
        end

        if type -q fdfind
            alias fd='fdfind --hidden --exclude .git'
            alias f='$EDITOR (fd -t f -t l | __fzfcmd)'
        end
end

# fzf configuration
if type -q fzf
    if not set -q FZF_DEFAULT_OPTS
        set -gx FZF_DEFAULT_OPTS "\
            -0 \
            -1 \
            --highlight-line \
            --info=inline-right \
            --ansi \
            --layout=reverse \
            --border=none \
            --height 60% \
            --no-multi"

        # Catppuccin color scheme
        set -gx FZF_DEFAULT_OPTS "$FZF_DEFAULT_OPTS \
            --color=bg+:#313244,bg:#1E1E2E,spinner:#F5E0DC,hl:#F38BA8 \
            --color=fg:#CDD6F4,header:#F38BA8,info:#CBA6F7,pointer:#F5E0DC \
            --color=marker:#B4BEFE,fg+:#CDD6F4,prompt:#CBA6F7,hl+:#F38BA8 \
            --color=selected-bg:#45475A \
            --color=border:#6C7086,label:#CDD6F4"
    end
    set -gx FZF_DEFAULT_COMMAND "fd --type f --strip-cwd-prefix --hidden --follow --exclude .git"
end

# bat configuration
if type -q bat
    alias cat='bat --color=always --theme="catppuccin_mocha"'
end

# rg configuration
if type -q rg
    alias rg='rg -H --column -n -S --no-heading --hidden --no-binary'
end

# dust configuration
if type -q dust
    alias du='dust -X .git'
end

# xh configuration
if type -q xh
    alias wget='xh --download'
end

# duf configuration
if type -q duf
    alias df='duf'
end

# taskell configuration
if type -q taskell
    alias task='taskell ~/taskell.md'
end

# Clipboard aliases
if type -q pbcopy
    # macOS already has pbcopy
else if type -q xclip
    alias pbcopy='xclip -selection c'
else if type -q xsel
    alias pbcopy='xsel --clipboard --input'
else
    echo 'Install xclip or xsel'
end

# Safe file operations
alias rm='rm -i'
alias cp='cp -ip'
alias mv='mv -i'

# Git aliases
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

# Docker aliases
alias dp='docker container ls'
alias di='docker image ls'
alias dv='docker volume ls'
alias dn='docker network ls'
alias drmp='docker rm (dp -q -f "status=exited")'
alias drmi='docker rmi (di -q -f "dangling=true")'

# lazygit
if type -q lazygit
    alias l='lazygit'
end

# tig
if type -q tig
    alias t='tig'
    alias ta='tig --all'
    alias ts='tig status'
end

# tmuxinator
if type -q tmuxinator
    alias tx='tmuxinator'
end

# ranger
alias r='ranger'

# nvim aliases
alias v='nvim'
alias vim='nvim'
alias vc='nvim --clean'
alias vimc='nvim --clean'
alias vimdiff='nvim -d'
alias m='v $HOME/memo.md'

# History removal (fish-specific)
alias rmhist='history clear && rm -f ~/.local/share/fish/fish_history && exit'

# Go to repository root
alias q='goto_repo_root'

function goto_repo_root
    if git rev-parse --is-inside-work-tree >/dev/null 2>&1
        cd (git rev-parse --show-toplevel)
    end
end

# Change to parent directory (Ctrl+U binding)
function chdir_parent
    echo
    cd ..
    commandline -f repaint
end
bind \cu chdir_parent

# fzf command helper
function __fzfcmd
    if set -q TMUX_PANE
        and test "$FZF_TMUX" != 0
        or set -q FZF_TMUX_OPTS
        echo "fzf-tmux $FZF_TMUX_OPTS -- "
    else
        echo fzf
    end
end

# Git repository change directory (Ctrl+S binding)
function git_repo_cd
    set -l selected_dir (ghq list --full-path | eval (__fzfcmd))
    if test -z "$selected_dir"
        commandline -f repaint
        return 0
    end
    clear
    builtin cd -- $selected_dir
    ls
    commandline -f repaint
end
bind \cs git_repo_cd

# Subdirectory change directory (Ctrl+O binding)
function subdir_cd
    if type -q fd
        set -l selected_dir (fd -t d | eval (__fzfcmd))
    else
        set -l selected_dir (find . -type d | eval (__fzfcmd))
    end
    if test -z "$selected_dir"
        commandline -f repaint
        return 0
    end
    builtin cd -- $selected_dir
    commandline -f repaint
end
bind \co subdir_cd

# History search with fzf (Ctrl+R binding)
function history_widget
    set -l selected (history | eval (__fzfcmd))
    if test -n "$selected"
        commandline -r $selected
    end
    commandline -f repaint
end
bind \cr history_widget

# IPv4 address selector
alias ipv4='ipv4_address'

function ipv4_address
    set -l ipv4_address (ifconfig | awk '$0 ~ /inet [0-9]+.[0-9]+.[0-9]+.[0-9]+/{ print $2 }' | eval (__fzfcmd))
    if test -z "$ipv4_address"
        return 0
    end
    echo "$ipv4_address"
end

# Package search
alias sp='pkg_search'

function pkg_search
    switch (uname)
        case Linux
            set -l selected_pkg (dpkg -l | awk '/^ii/ { print $2 }' | eval (__fzfcmd))
            if test -z "$selected_pkg"
                return 0
            end
            apt-cache depends $selected_pkg
            echo
            apt-cache rdepends $selected_pkg

        case Darwin
            set -l selected_formula (brew list -1 | eval (__fzfcmd))
            if test -z "$selected_formula"
                return 0
            end
            echo "$selected_formula depends on..."
            brew deps $selected_formula 2>/dev/null
            echo
            echo "$selected_formula is used by..."
            brew uses --eval-all $selected_formula 2>/dev/null
            echo
    end
end

# Custom tmux session management
function custom_tmux_session
    if test (count $argv) -ge 1
        set -l ID $argv[1]
        if set -q TMUX
            tmux new-session -d -s"$ID"
            tmux switch-client -t "$ID"
        else
            tmux new-session -s"$ID"
        end
    else
        set -l ID (tmux list-sessions 2>/dev/null | eval (__fzfcmd) | cut -d: -f1)
        if test -z "$ID"
            tmux new-session -s default
            return
        end
        if set -q TMUX
            tmux switch-client -t "$ID"
        else
            tmux attach-session -t "$ID"
        end
    end
end

# Send command to tmux session
function custom_send_to_session
    if test (count $argv) -lt 1
        return
    end
    set -l ID (tmux list-sessions 2>/dev/null | eval (__fzfcmd) | cut -d: -f1)
    if test -z "$ID"
        tmux new-session -s defaulttmux new-window -t default "$argv"
        return
    end
    tmux new-window -t "$ID" "$argv"
end

# Terminal multiplexer aliases
if type -q tmux
    alias s='custom_tmux_session'
    alias a='custom_send_to_session'
else if type -q zellij
    alias s='zellij'
else if type -q screen
    alias s='screen'
end

# OS-specific environment variables
switch (uname)
    case Darwin
        set -gx STM32CubeMX_PATH /Applications/STMicroelectronics/STM32CubeMX.app/Contents/Resources
        set -gx STM32_PRG_PATH /Applications/STMicroelectronics/STM32Cube/STM32CubeProgrammer/STM32CubeProgrammer.app/Contents/MacOs/bin

    case Linux
        set -gx CPLUS_INCLUDE_PATH /usr/include/c++/11:/usr/include/x86_64-linux-gnu/c++/11
end

# Fish doesn't need compilation like zsh
# Configuration is automatically loaded from ~/.config/fish/config.fish
