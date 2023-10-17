alias rm='rm -i'
alias cp='cp -ip'
alias mv='mv -i'
alias t='tig'
alias ta='tig --all'
alias s='tmux'
if [ -x /usr/bin/xsel ]; then
  alias pbcopy='xsel --clipboard --input'
else if [ -x /usr/bin/xclip ]; then
  alias pbcopy='xsel -selection c'
else
  echo "Install xclip or xsel"
fi

