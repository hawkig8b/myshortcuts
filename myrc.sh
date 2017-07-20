alias bashrc="nano ~/.bashrc && source ~/.bashrc"
alias myrc="nano ~/.myrc && source ~/.myrc"
alias zshrc="nano ~/.zshrc && source ~/.zshrc"



#-------------------- ls
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'


#-------------------- Directory
alias cd..='cd ..'
alias ..='cd ..'
alias .2='cd ../../'
alias .3='cd ../../../'
alias .4='cd ../../../../'
alias .5='cd ../../../../..'
alias mkdir='mkdir -pv'
alias back='cd "$OLDPWD"'
#alias back="cd -"

#-------------------- Apt
alias update='sudo apt-get update && sudo apt-get upgrade -y'
alias apti='sudo apt install'

#-------------------- Git
alias gits='git status'
alias gitl='git log --decorate --oneline --graph'
alias gitco='git checkout'
alias gitd='git diff --color-words'
alias gitdh='git diff HEAD --color-words'
alias gitds='git diff --staged --color-words'
alias gitpr='git pull --rebase'
alias gitss='git stash save'
alias gitsp='git stash pop'
alias gitsu='git submodule update --rebase --remote --recursive --init'

#-------------------- Miscellaneous
alias ppjson='python -m json.tool'
alias cnt="wc -l"
