
# set vi mode on bash shell
set -o vi

# use vim or nvim:
export VISUAL=vim

alias ssh='ssh -X'
alias v=$VISUAL
alias vi=$VISUAL
alias vim=$VISUAL
alias vim8='/usr/bin/vim'
alias nvim='/usr/bin/nvim'

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# lynx editor support
alias lynx='lynx -editor=vim'

# plantUML shortcut
alias plantuml='java -jar ~/Software/plantuml.jar'

# Nodejs specific stuff required for copilot in vim
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

if [ -f ~/.bash_credentials ]
then
    . ~/.bash_credentials
fi
