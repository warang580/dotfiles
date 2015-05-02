# File listing
alias ll='ls -lFh'
alias l1='ls -1h'
alias la='ls -AlFh'
alias l='ll'

# Disk usage
alias df="df -h"
alias du="du -h"

# Interactive delete
alias rm='rm -i'

# Path displaying
alias path='echo $PATH | tr -s ":" "\n"'

# Changing directories
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# Package install
alias install='sudo apt-get install'

# TMUX
alias tmuxr='tmux attach'

# "Fuck" corrector
alias fuck='eval $(thefuck $(fc -ln -1))'
alias FUCK='fuck'


