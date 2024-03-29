# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

if [[ $- == *i* ]]
then
    bind '"\e[A": history-search-backward'
    bind '"\e[B": history-search-forward'
fi

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=2000
HISTFILESIZE=5000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# autocomplete only directories with cd
complete -d cd

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Aliases
alias ...='cd ../..'
alias ..='cd ..'
alias vi=vim
alias l='ls -lF'
alias brew='/opt/homebrew/bin/brew'
alias oldbrew='/usr/local/bin/brew'

alias g='git'
alias ga='git add'
alias gaa='git add .'
alias gc='git commit'
alias gcm='git commit -m'
alias gss='git status'
alias gk='gitk --all'

alias pgstart='brew services start postgresql'
alias pgstop='brew services start postgresql'


if [ "$(uname)" == "Darwin" ]; then
# Do something under Mac OS X platform
alias ls='ls -G' # enable color support in ls

else
# Do something under GNU/Linux platform

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

fi

function prompt_command {
    exitstatus="$?"

    BOLD="\[\033[1m\]"
    RED="\[\033[0;38;5;9m\]"
    GREEN="\[\033[0;38;5;10m\]"
    BLUE="\[\033[0;38;5;27m\]"
    PURPLE="\[\033[0;38;5;21m\]"
    CYAN="\[\033[0;38;5;39m\]"
    YELLOW="\[\033[0;38;5;226m\]"
    OFF="\[\033[0m\]"

    changes=`git status -s 2> /dev/null | wc -l | sed -e 's/ *//'`
    if [ ${changes} -eq 0 ]; then
        dirty=" ${GREEN}v${OFF}"
    else
        dirty=" ${RED}x${OFF}"
    fi
    branch=`git symbolic-ref HEAD 2> /dev/null | cut -f3 -d/`
    if [ ! -z ${branch} ]; then
        if [ ${branch} == "master" ]; then
            branch=`echo " (${BLUE}${branch}${dirty}${OFF})"`
        else
            branch=`echo " (${PURPLE}${branch}${dirty}${OFF})"`
        fi
    fi

    window_title="\[\e]0;\W\a\]"
    current_time="[\t] "
    prompt="${window_title}${OFF}${CYAN}${OFF}\u@\h: ${CYAN}\w${OFF}${branch}"

    if [ ${exitstatus} -eq 0 ]; then
        PS1="${prompt} ${GREEN}> ${OFF}${YELLOW}${BOLD}"
    else
        PS1="${prompt} ${RED}> ${OFF}${YELLOW}${BOLD}"
    fi
    trap 'echo -ne "\033[0m"' DEBUG

    PS2="${BOLD}>${OFF} "
}
PROMPT_COMMAND=prompt_command

# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

if [ -f ~/.git-completion.bash ]; then
    . ~/.git-completion.bash
fi

export EDITOR=vim

bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
bind '"\eOA": history-search-backward'
bind '"\eOB": history-search-forward'

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin:/opt/homebrew/bin"

export PATH="/opt/homebrew/bin:"$PATH
export PATH=$(pyenv root)/shims:$PATH

eval "$(fnm env --use-on-cd)"

# Add colors to Terminal
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced
export LSCOLORS=GxFxCxDxBxegedabagaced

# For psycopg2 install in pip
# For compilers to find openssl@1.1 you may need to set:
export LDFLAGS="-L/opt/homebrew/opt/openssl@1.1/lib"
export CPPFLAGS="-I/opt/homebrew/opt/openssl@1.1/include"

# For pkg-config to find openssl@1.1 you may need to set:
export PKG_CONFIG_PATH="/opt/homebrew/opt/openssl@1.1/lib/pkgconfig"

export BASH_SILENCE_DEPRECATION_WARNING=1

fortune | pokemonsay
