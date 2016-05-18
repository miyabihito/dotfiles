# alias
alias l='ls'
alias ll='ls -l'
alias la='ls -a'
alias lla='ls -al'
alias ex='exit'
alias ..='cd ..'


# history
HISTCONTROL=ignoreboth
HISTFILESIZE=10000
HISTSIZE=10000
HISTTIMEFORMAT='%Y%m%d %T '
shopt -s histappend


# bash options
#shopt -s autocd


# git
if [ -r ~/.git-completion.bash ]; then
	. ~/.git-completion.bash
fi
if [ -r ~/.git-prompt.sh ]; then
	. ~/.git-prompt.sh
fi


# prompt
GIT_PS1_SHOWSTASHSTATE=true
PS1="[\[\e[1;30m\]\t\[\e[00m\]][\[\e[1;34m\]\h\[\e[00m\]:\w]\$(__git_ps1 ' (\[\e[0;36m\]%s\[\e[00m\])') \$ "


# nvm (Node Version Manager https://github.com/creationix/nvm)
if [ -d "$HOME/.nvm" ]; then
	export NVM_DIR="$HOME/.nvm"
	[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
	[ -r "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"
fi
