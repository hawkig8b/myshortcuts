alias bashrc="nano ~/.bashrc && source ~/.bashrc"
alias zshrc="nano ~/.zshrc && source ~/.zshrc"
MYRC_HOME="~/myshortcuts"
alias myrc="nano $MYRC_HOME/myrc.sh && source $MYRC_HOME/myrc.sh && syncup"
alias syncdown="cd $MYRC_HOME && git pull --rebase ; cd -"
alias syncup="cd $MYRC_HOME && git add myrc.sh && git commit -m 'syncing myrc.sh' && git push origin master; cd -"


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

#gradle
alias gwb='./gradlew build -Dorg.gradle.daemon=true'
alias gwcb='./gradlew clean build -Dorg.gradle.daemon=true'

#-------------------- Miscellaneous
alias ppjson='python -m json.tool'
alias cnt="wc -l"
alias toclipboard="xclip -selection c"
alias fromclipboard="xclip -selection clipboard -o"
