#!/bin/zsh

alias bashrc="nano ~/.bashrc && source ~/.bashrc"
alias zshrc="nano ~/.zshrc && source ~/.zshrc"
MYRC_HOME=${0:a:h}
alias myrc="nano -c $MYRC_HOME/myrc.sh && source $MYRC_HOME/myrc.sh"
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
cd $MYRC_HOME
git config user.name "hawkig8b"
git config user.email "hawkig8b@gmail.com"
cd -
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



#------------------------------------
install_list=(

atom #advanced text editor
cowsay # show a cool cow message
curl
git
gitk
gitg
glipper #multi-item clipboard utility
guake #drop-down terminal shell
htop #interactive process viewer
inotify-tools #monitor file system and react to change. e.g.: while inotifywait -e modify <file or dir> ;do .... ; done
regexxer #a gui-application to search text and replace in-place using regex.
silversearcher-ag #cl regex search
synaptic #package manager
tig #cl git tool
tmux #termial tool
tree #print directory tree structure
uget #a gui downlaod manager
unp #cl unzip utility
xclip #cl clipboard utility

)

GREEN_CHECK_SIGN="\e[0;32m\xE2\x9C\x94\e[0m"
RED_CROSS_SIGN="\e[0;31m\xe2\x9c\x98\e[0m"


function print_title_line {
  print "=================== ${@} ========================"
}

function install_apps {
  rm -f /tmp/install_apps_out.log tmp/install_apps_err.log
  print_title_line "Updating the apt index"
  sudo apt-get update >>/tmp/install_apps_out.log 2>>/tmp/install_apps_err.log
  for item in $install_list ;do
    print_title_line "installing" $item
    sudo apt-get install $item >>/tmp/install_apps_out.log 2>>/tmp/install_apps_err.log
    if [ $? -eq 0 ]; then
      echo $GREEN_CHECK_SIGN "DONE"
    else
      echo $RED_CROSS_SIGN "NOT SUCCESSFUL"
    fi
  done
}
