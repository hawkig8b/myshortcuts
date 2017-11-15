#!/bin/zsh

alias bashrc="nano ~/.bashrc && source ~/.bashrc"
alias zshrc="nano ~/.zshrc && source ~/.zshrc"
MYRC_HOME=${0:a:h}
alias myrc="nano -c $MYRC_HOME/myrc.sh && source $MYRC_HOME/myrc.sh"
alias myhacks="nano -c $MYRC_HOME/myHacks.txt"
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
alias update='sudo apt-get update && sudo apt-get upgrade -y && sudo apt-get upgrade && sudo apt autoremove -y'
alias apti='sudo apt install'

#-------------------- Git
cd $MYRC_HOME
#git config user.name "hawkig8b"
#git config user.email "hawkig8b@gmail.com"
cd -
alias gits='git status'
alias gitl='git log --decorate --oneline --graph'
alias gitco='git checkout'
alias gitca='git commit --amend'
alias gitd='git diff --color-words'
alias gitdh='git diff HEAD --color-words'
alias gitds='git diff --staged --color-words'
alias gitpr='git pull --rebase'
alias gitss='git stash save'
alias gitsp='git stash pop'
alias gitsu='git submodule update --rebase --remote --recursive --init'
alias gitpg='git push origin HEAD:refs/for/master'

#gradle
alias gwb='./gradlew build -x checkstyleMain -x checkstyleTest -Dorg.gradle.daemon=true | tee build.log'
alias gwcb='./gradlew clean build -x checkstyleMain -x checkstyleTest -Dorg.gradle.daemon=true | tee build.log'
alias gwbCheckstyle='./gradlew build -Dorg.gradle.daemon=true | tee build.log'
alias gwcbCheckstyle='./gradlew clean build -Dorg.gradle.daemon=true | tee build.log'
alias dcu='./gradlew dCU -Plocal=true'

#-------------------- Miscellaneous
alias cur_dir_size='du -sh .'
alias ppjson='python -m json.tool'
alias cnt="wc -l"
alias pbcopy="xclip -selection c"
alias pbpaste="xclip -selection clipboard -o"
alias tmuxcp="tmux show-buffer | toclipboard"
#usage: 1) ctrl+b,[ 2)goto start then space 3)goto end then enter  4)ctrl+b,] to paste or this alias to copy to clipboard 


#------------------------------------
install_list=(

atom #advanced text editor
cowsay # show a cool cow message
curl
git
git-core
gitk
gitg
glipper #multi-item clipboard utility
guake #drop-down terminal shell
htop #interactive process viewer
inotify-tools #monitor file system and react to change. e.g.: while inotifywait -e modify <file or dir> ;do .... ; done
lolcat #colorful output
regexxer #a gui-application to search text and replace in-place using regex.
silversearcher-ag #cl regex search
synaptic #package manager
tig #cl git tool
tmux #termial tool
tree #print directory tree structure
uget #a gui downlaod manager
unp #cl unzip utility
wget
xclip #cl clipboard utility

)

GREEN_CHECK_SIGN="\e[0;32m\xE2\x9C\x94\e[0m"
RED_CROSS_SIGN="\e[0;31m\xe2\x9c\x98\e[0m"

function install_third_party_keys {
  echo "Adding 3rd party repositories ..."
  sudo add-apt-repository ppa:webupd8team/atom
}

function install_apps {
  rm -f /tmp/install_apps_out.log tmp/install_apps_err.log

  echo "Updating the apt index ..."
  sudo apt-get update >>/tmp/install_apps_out.log 2>>/tmp/install_apps_err.log

  for item in $install_list ;do
    echo -n "installing" $item "... "
    sudo apt-get install $item -y  >>/tmp/install_apps_out.log 2>>/tmp/install_apps_err.log
    if [ $? -eq 0 ]; then
      echo $GREEN_CHECK_SIGN
    else
      echo $RED_CROSS_SIGN
    fi
  done
}



#====================== Betty
export BETTY_HOME="/home/nvd/betty"
alias gobetty="cd $BETTY_HOME"
alias goui="cd $BETTY_HOME/betty_orderfulfillment_ui"
alias gosecrets="cd $BETTY_HOME/betty_secrets"
alias gopublicapi="cd $BETTY_HOME/betty_orderfulfillment_publicapi"
alias goorderservice="cd $BETTY_HOME/betty_orderfulfillment_orderservice"
alias gocombi="cd $BETTY_HOME/betty_ordermanagement_combiorder"
alias gosearch="cd $BETTY_HOME/betty_ordermanagement_search"
alias gomailservice="cd $BETTY_HOME/betty_orderfulfillment_mailservice"
alias gobuildsupport="cd $BETTY_HOME/betty_build_support"
alias gokubernetes="cd $BETTY_HOME/betty_orderfulfillment_kubernetes"
alias godockercompose="cd $BETTY_HOME/betty_build_support/etc/docker-compose"

alias dockerup="cd $BETTY_HOME/betty_build_support/etc/docker-compose && docker-compose up -d"
export CQLSH_NO_BUNDLED=true
alias bettyup="cd $BETTY_HOME/betty_build_support/etc/docker-compose && docker-compose up -d"
alias bettyUiDown="docker ps | grep -C 0 orderfulfillment/ui:DEV |  tee /dev/tty  | head -1 | awk '{print $1;}' | xargs docker stop"
alias bettyStopLocalUI="docker ps | grep -C 0 build | tee /dev/tty  | awk '{print $1;}' | xargs docker stop"
alias bettyStartLocalUI="cd $BETTY_HOME/betty_orderfulfillment_ui/ui/ && ./docker-gulp.sh serve"
alias updatecontainers="cd /home/nvd/fixstuff/betty_build_support && git pull --rebase &&
cd /home/nvd/fixstuff/betty_build_support/etc/docker-compose && docker-compose pull"
