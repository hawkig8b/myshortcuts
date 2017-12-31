#!/bin/zsh

NVDSH_HOME=${0:a:h}
alias gonvdsh="cd $NVDSH_HOME"

alias bashrc="nano ~/.bashrc && source ~/.bashrc"
alias zshrc="nano ~/.zshrc && source ~/.zshrc"
alias nvdrc="nano -c $NVDSH_HOME/nvdrc.sh && syncup && source $NVDSH_HOME/nvdrc.sh"
alias myhacks="nano -c $NVDSH_HOME/myHacks.txt"

alias pbcopy="xclip -selection c"
alias pbpaste="xclip -selection clipboard -o"
alias ppjson='python -m json.tool'


#-------------------- ls
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

#-------------------- colors
RED='\033[0;31m'
NC='\033[0m' # No Color

#---------------------
function msg() {
  echo "${RED}"$@"${NC}"
}

#-------------------- Directory
alias cd..='cd ..'
alias ..='cd ..'
alias up='cd ..'
alias .2='cd ../../'
alias .3='cd ../../../'
alias .4='cd ../../../../'
alias .5='cd ../../../../..'
alias mkdir='mkdir -pv'
alias back='cd -'
alias desk='cd ~/Desktop'

#-------------------- Git
cd $NVDSH_HOME
git config user.name "hawkig8b"
git config user.email "hawkig8b@gmail.com"
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

#-------------------- Miscellaneous
alias cur_dir_size='du -sh .'
alias ppjson='python -m json.tool'
alias cnt="wc -l"
alias tmuxcp="tmux show-buffer | toclipboard"
#usage: 1) ctrl+b,[ 2)goto start then space 3)goto end then enter  4)ctrl+b,] to paste or this alias to copy to clipboard

function cdl { cd $1 && ls }

function createTmpFile {
  echo $(mktemp)$(echo "_")$(date +"%y%m%d-%H%M%S")$1
}

function viewjson {
  TEMPJSON=$(createTmpFile .json) &&
  pbpaste | ppjson > $TEMPJSON
  if [ $? -eq 0 ]; then
    xdg-open $TEMPJSON
  else
    zenity --error --text="Error Processing Json" --title="NVDSH"
  fi
}

function syncdown {
  msg 'updating nvdsh' &&
  curdir=$PWD &&
  gonvdsh &&
  git pull --rebase &&
  source nvdrc.sh ;
  cd $curdir
}

function syncup {
  curdir=$PWD &&
  gonvdsh &&
  git add . &&
  commitMsg=$(zenity --entry --title="NVDSH" --text="Commit Message" 2> /dev/null) &&
  [[ ! -z "${commitMsg// }" ]] &&  #aborts if commitMsg is empty
  git commit -m $commitMsg &&
  git push origin master ;
  cd $curdir
}

function updateApt {
  msg "updating apt index ..." &&
  sudo apt-get update &&
  msg "upgrading apt ..." &&
  sudo apt-get upgrade -y &&
  msg "upgrading distribution ..." &&
  sudo apt-get dist-upgrade
  msg "cleaning up apt packages ..." &&
  sudo apt autoremove -y
}

function tryUpdating {
  touch $NVDSH_HOME/.lastUpdatedDay
  [[ $(date +%y%m%d) = $(cat $NVDSH_HOME/.lastUpdatedDay)  ]] ||
  ( echo $(date +%y%m%d) > $NVDSH_HOME/.lastUpdatedDay && askUpdate )
}

function askUpdate {
  read -q "doUpdate?Run the update?"
  echo "\n"
  if [ $doUpdate = "y" ]; then
    syncdown
    updateApt
    upgrade_oh_my_zsh;
  else
    return 1
  fi
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

#gradle
alias gdcu='./gradlew dCU -Plocal=true -x checkstyleMain -x checkstyleTest -Dorg.gradle.daemon=true | tee build.log'
alias gwb='./gradlew build -x checkstyleMain -x checkstyleTest -Dorg.gradle.daemon=true | tee build.log'
alias gwcb='./gradlew clean build -x checkstyleMain -x checkstyleTest -Dorg.gradle.daemon=true | tee build.log'
alias gwbCheckstyle='./gradlew build -Dorg.gradle.daemon=true | tee build.log'
alias gwcbCheckstyle='./gradlew clean build -Dorg.gradle.daemon=true | tee build.log'

cat $NVDSH_HOME/banner.txt
