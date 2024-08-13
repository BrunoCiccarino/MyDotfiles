
export ZSH="$HOME/.oh-my-zsh"
export ZPLUG_HOME=$HOME/.zplug
source $ZPLUG_HOME/init.zsh

zplug "dracula/zsh", as:theme

ZSH_THEME="dracula"


plugins=(
	zsh-autosuggestions 
	git
)

source $ZSH/oh-my-zsh.sh



source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
