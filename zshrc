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
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
fortune | pokemonsay
