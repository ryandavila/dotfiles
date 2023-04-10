# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

zmodload zsh/zprof
# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="powerlevel10k/powerlevel10k"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

#export LC_CTYPE=C
#export LANG=C

export EDITOR=nvim

export HOMEBREW_CASK_OPTS="--appdir=/Applications"

PS1="%{\$PROMPT_SUCCESS_COLOR%}% %{\$reset_color%}% $PS1"

# Customize to your needs...
export PATH="/opt/homebrew/bin:/usr/local/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/X11/bin:$HOME/Library/bin:/opt/homebrew/bin:$PATH"

# rvm configuration
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
#[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# Aliases
alias reload='exec zsh -l'
alias vi='nvim'
alias jn='jupyter notebook'
alias ...='cd ../..'
alias vstart='source venv/bin/activate; source .env; python app.py'
alias brew='/opt/homebrew/bin/brew'
alias oldbrew='/usr/local/bin/brew'

alias g='git'
alias ga='git add'
alias gaa='git add .'
alias gc='git commit'
alias gcm='git commit -m'
alias gss='git status'

alias pg-start="pg_ctl -D /usr/local/var/postgres start"
alias pg-stop="pg_ctl -D /usr/local/var/postgres stop"
alias pg-restart="pg_ctl -D /usr/local/var/postgres restart"


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

alias java8='export JAVA_HOME=$JAVA_8_HOME'
alias java11='export JAVA_HOME=$JAVA_11_HOME'

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

# export PYENV_ROOT="$HOME/.pyenv"
# command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
# eval "$(pyenv init -)"
export PATH="/opt/homebrew/bin:"$PATH
export PATH=$(pyenv root)/shims:$PATH

eval "$(fnm env --use-on-cd)"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

fortune | pokemonsay
# fortune | say & disown
