zmodload zsh/zprof
# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="muse"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

#export LC_CTYPE=C
#export LANG=C

export EDITOR=vim

export HOMEBREW_CASK_OPTS="--appdir=/Applications"

PS1="%{\$PROMPT_SUCCESS_COLOR%}% [%D{%H:%M:%S}] %{\$reset_color%}% $PS1"

# Customize to your needs...
export PATH="/usr/local/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/X11/bin:$HOME/Library/bin:$PATH"

# Source aliases from another file
if [[ -e $HOME/.zsh_aliases.zsh ]]; then
    source $HOME/.zsh_aliases.zsh
fi

# rvm configuration
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
#[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

#aliases
alias reload='exec $SHELL -l'
alias vi='vim'
alias jn='jupyter notebook'
alias ...='cd ../..'

function mkcd {
  dir="$*";
  mkdir -p "$dir" && cd "$dir";
}

function safe_rm() {
    ORIGINAL_ARGS=("$@")
    TO_TRASH=true
    VERBOSITY=false
    while getopts ":if" opt; do
        case "$opt" in
            f)
                TO_TRASH=false
                ;;
            i)
                VERBOSITY=true
                ;;
        esac
    done
    shift $((OPTIND-1))
    if [ "$TO_TRASH" = true ]; then
        if [ "$VERBOSITY" = true ]; then
            mv -v "$@" ~/.Trash
        else
            mv "$@" ~/.Trash
        fi
    else
        \rm $ORIGINAL_ARGS
    fi
}
alias rm=safe_rm

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
#eval "$(pyenv init -)"

################################################################################
# Lazy loading language specific environments (speed up zsh load)
# Credits: https://gist.github.com/QinMing/364774610afc0e06cc223b467abe83c0
################################################################################

lazy_load() {
    # Act as a stub to another shell function/command. When first run, it will load the actual function/command then execute it.
    # $1: space separated list of alias to release after the first load
    # $2: file to source
    # $3: name of the command to run after it's loaded
    # $4+: argv to be passed to $3
    echo "Lazy loading $1 ..."

    # $1.split(' ') using the s flag. In bash, this can be simply ($1) #http://unix.stackexchange.com/questions/28854/list-elements-with-spaces-in-zsh
    # Single line won't work: local names=("${(@s: :)${1}}"). Due to http://stackoverflow.com/questions/14917501/local-arrays-in-zsh   (zsh 5.0.8 (x86_64-apple-darwin15.0))
    local -a names
    if [[ -n "$ZSH_VERSION" ]]; then
        names=("${(@s: :)${1}}")
    else
        names=($1)
    fi
    unalias "${names[@]}"
    source $2
    shift 2
    $*
}

group_lazy_load() {
    local script
    script=$1
    shift 1
    for cmd in "$@"; do
        alias $cmd="lazy_load \"$*\" $script $cmd"
    done
}

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
group_lazy_load "$HOME/.rvm/scripts/rvm" rvm ruby gem rake

group_lazy_load "$HOME/.opam/opam-init/init.zsh" opam ocaml utop

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
#group_lazy_load "$HOME/.pyenv/init.zsh" pyenv python python3 pip pip3
group_lazy_load "$HOME/.pyenv/init.zsh" pyenv python python3 pip pip3 jupyter

unset -f group_lazy_load

fortune | pokemonsay
# fortune | say & disown

