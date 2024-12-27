# ~/.bash_profile
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi
[[ "$(fgconsole 2>/dev/null)" -eq 1 ]] && exec startx > /dev/null 2>&1

# Default programs
export EDITOR="nvim"
export TERMINAL="st"
export TERMINAL_PROG="st"
export BROWSER="firefox"

# Environment variables
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export PATH="$PATH:$HOME/.local/bin"
export WGETRC="$XDG_CONFIG_HOME/wget/wgetrc"
