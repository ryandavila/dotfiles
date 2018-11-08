# Alias definitions.
alias ..='cd ..'
alias l='ls -lF'
alias rm='rm -i'

alias gl='git pull'
alias gp='git push'
alias gt='git log --oneline --decorate --graph --color --all'

alias vi='vim'

alias valgrind='valgrind --trace-children=yes --read-var-info=yes --sigill-diagnostics=yes --leak-check=full --show-leak-kinds=all'

function rm() {
    if [ "$#" -eq "1" ]; then
        return
    fi
    DIR=~/.trash/"$(date +'%c')"
    DIR=${DIR// /_}
    mkdir -p $DIR
    mv "$@" $DIR

    /bin/rm -f ~/.trash/latest
    ln -s $DIR ~/.trash/latest
}

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
