# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
PATH="$HOME/.emacs.d/bin:$PATH"

export ALTERNATE_EDITOR=""
export EDITOR="emacsclient -t"
export VISUAL="emacsclient -c -a emacs"
export PATH
eval "$(starship init bash)"
# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions

alias sc='source ~/.bashrc'
alias em='emacsclient -t'
alias emacs='emacsclient -c'
alias emkill="emacsclient -e '(kill-emacs)'"
alias xrl='xrdb ~/.Xresources'
alias i3conf="emacsclient -t ~/.config/i3/config"
[ -f "/home/zcampbell/.ghcup/env" ] && source "/home/zcampbell/.ghcup/env" # ghcup-env
