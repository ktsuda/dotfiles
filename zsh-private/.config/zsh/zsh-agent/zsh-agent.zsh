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

