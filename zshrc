# Change $PATH.
export PATH=$PATH:./vendor/bin/:$HOME/.composer/vendor/bin

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Path to your configuration.
export ZSH_CONFIG="$HOME/zshconfig"

# Set name of the theme to load. 
export ZSH_THEME="homelike"

# Would you like to use another custom folder than $ZSH/custom?
export ZSH_CUSTOM="$ZSH_CONFIG/custom"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git composer laravel5 vim-interaction zsh_reload)

source $ZSH/oh-my-zsh.sh

# User configuration

# Aliases.
alias zshconfig="vim ~/zshconfig/zshrc"
alias zshaliases="vim ~/zshconfig/zsh_aliases"
alias ohmyzsh="vim ~/.oh-my-zsh"

# Commom aliases.
if [ -f $HOME/.zsh_aliases ]; then
    source $HOME/.zsh_aliases
fi

# Custom aliases (for example any workplace-specific aliases).
if [ -f $HOME/.zsh_custom_aliases ]; then
    source $HOME/.zsh_custom_aliases
fi
