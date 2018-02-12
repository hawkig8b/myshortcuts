#!/bin/zsh

NVDSH_HOME=${0:a:h}
function gonvdsh { cd $NVDSH_HOME }

function bashrc { nano ~/.bashrc && source ~/.bashrc }
function zshrc { nano ~/.zshrc && source ~/.zshrc }
function nvdrc { nano -c $NVDSH_HOME/nvdrc.sh && syncup && source $NVDSH_HOME/nvdrc.sh }
function myhacks { nano -c $NVDSH_HOME/myHacks.txt }

function pbcopy { xclip -selection c }
function pbpaste { xclip -selection clipboard -o }
function ppjson= { python -m json.tool }

#-------------------- ls
function ll { ls -alF }
function la { ls -A }
function l { ls -CF }

#-------------------- colors
RED='\033[0;31m'
NOCOLOR='\033[0m'

#---------------------
function msg() {
  echo "${RED}"$@"${NOCOLOR}"
}

#-------------------- Directory
function cd.. { cd .. }
function .. { cd .. }
function up { cd .. }
function .2 { cd ../../ }
function .3 { cd ../../../ }
function .4 { cd ../../../../ }
function .5 { cd ../../../../.. }
function mkdir { mkdir -pv }
function back { cd - }
function desk { cd ~/Desktop }

#-------------------- Git
cd $NVDSH_HOME
git config user.name "hawkig8b"
git config user.email "hawkig8b@gmail.com"
git config --global push.default simple
cd -


#------------------- git

function gits { git status }
function gitl { git log --decorate --oneline --graph }
function gitco { git checkout }
function gitca { git commit --amend }
function gitcan { git commit --amend --no-edit }
function gitd { git diff --color-words }
function gitdh { git diff HEAD --color-words }
function gitds { git diff --staged --color-words }
function gitpr { git pull --rebase }
function gitss { git stash save }
function gitsp { git stash pop }
function gitsu { git submodule update --rebase --remote --recursive --init }
function gitpg { git push origin HEAD:refs/for/master }

#--------------------- Unity Directories
function goUnityLaunchers { cd ~/.local/share/applications }

#-------------------- Miscellaneous
function cur_dir_size { du -sh . }
function ppjson { python -m json.tool }
function cnt { wc -l }
function tmuxcp { tmux show-buffer | pbcopy }
#usage: 1) ctrl+b,[ 2)goto start then space 3)goto end then enter  4)ctrl+b,] to paste or this function to copy to clipboard

function cdl { cd $1 && ls }

function createTmpFile {  echo $(mktemp)$(echo "_")$(date +"%y%m%d-%H%M%S")$1 }

function viewjson {
  TEMPJSON=$(createTmpFile .json) &&
  pbpaste | ppjson > $TEMPJSON
  if [ $? -eq 0 ]; then
    xdg-open $TEMPJSON
  else
    zenity --error --text="Error Processing Json" --title="NVDSH"
  fi
}


function google {
  Query=""
  for arg in "$@"
  do
    Query="$Query%20$arg"
  done
  xdg-open https://www.google.com/search?q=$Query &
  unset Query
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

function doUpdate {
  syncdown
  updateApt
  upgrade_oh_my_zsh;
}

function followlog {
  CONTAINER_ID=$(docker-grep $1)
  docker logs -f --since 10s $CONTAINER_ID
}

function docker-grep { #usage docker-search order service
  docker ps| grep $1 | awk '{print $1;}'
}

function stopcontainers {
  docker ps -q | xargs docker stop
}

function playsh { #TODO: CORRECT THIS
  PLAY_DIR=$(mktemp -d) &&
  echo "zsh play.sh  "> command.sh
  chmod +x command.sh
  touch $PLAY_DIR/{Play.sh,output.txt,erro.txt,command.sh} &&
  atom $PLAY_DIR
  while inotify-change -e MODIFY . ; do command.sh ; done
}

#TODO : playkotlin, playjava, playpy, playrb, playcj, playnode

#TODO : function to  gen tech user JWT and copy to clipboard

#TODO : function that opens box atom for url.txt, body.json, and does the curl with minial effort (jwt already generated and in place)


#====================== Betty
export BETTY_HOME="/home/nvd/betty"
function gobetty { cd $BETTY_HOME}
function goinvoice { cd $BETTY_HOME/betty_checkout_invoice }
function goui { cd $BETTY_HOME/betty_orderfulfillment_ui }
function gosecrets { cd $BETTY_HOME/betty_secrets }
function gopublicapi { cd $BETTY_HOME/betty_orderfulfillment_publicapi }
function goorderservice { cd $BETTY_HOME/betty_orderfulfillment_orderservice }
function gocombi { cd $BETTY_HOME/betty_ordermanagement_combiorder }
function gosearch { cd $BETTY_HOME/betty_ordermanagement_search }
function gomailservice { cd $BETTY_HOME/betty_orderfulfillment_mailservice }
function gobuildsupport { cd $BETTY_HOME/betty_build_support }
function gokubernetes { cd $BETTY_HOME/betty_orderfulfillment_kubernetes }
function godockercompose { cd $BETTY_HOME/betty_build_support/etc/docker-compose }

function dockerup { cd $BETTY_HOME/betty_build_support/etc/docker-compose && docker-compose up -d }
export CQLSH_NO_BUNDLED=true
function bettyup { cd $BETTY_HOME/betty_build_support/etc/docker-compose && docker-compose up -d }
function bettyUiDown { docker ps | grep -C 0 orderfulfillment/ui:DEV |  tee /dev/tty  | head -1 | awk '{print $1;}' | xargs docker stop }
function bettyStopLocalUI { docker ps | grep -C 0 build | tee /dev/tty  | awk '{print $1;}' | xargs docker stop }
function bettyStartLocalUI { cd $BETTY_HOME/betty_orderfulfillment_ui/ui/ && ./docker-gulp.sh serve }
function updatecontainers { cd /home/nvd/fixstuff/betty_build_support && git pull --rebase &&
cd /home/nvd/fixstuff/betty_build_support/etc/docker-compose && docker-compose pull }

#gradle
function gdcu { ./gradlew dCU -Plocal=true -x checkstyleMain -x checkstyleTest -Dorg.gradle.daemon=true | tee build.log }
function gwb { ./gradlew build -x checkstyleMain -x checkstyleTest -Dorg.gradle.daemon=true | tee build.log }
function gwcb { ./gradlew clean build -x checkstyleMain -x checkstyleTest -Dorg.gradle.daemon=true | tee build.log }
function gwbCheckstyle { ./gradlew build -Dorg.gradle.daemon=true | tee build.log }
function gwcbCheckstyle { ./gradlew clean build -Dorg.gradle.daemon=true | tee build.log }
function gwspot { ./gradlew spotlessApply }
function doCheckstyleForReal { ./gradlew checkstyleMain checkstyleTest }
function gwba { ./gradlew spotlessApply build }

echo "${RED}" && cat $NVDSH_HOME/banner.txt ; echo "${NOCOLOR}"
