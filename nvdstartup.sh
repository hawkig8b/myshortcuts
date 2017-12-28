#!/bin/zsh
NVDSH_HOME=${0:a:h}
source $NVDSH_HOME/nvdrc.sh


function tryUpdating {
  touch $NVDSH_HOME/.lastUpdatedDay
  [[ $(date +%y%m%d) = $(cat $NVDSH_HOME/.lastUpdatedDay)  ]] ||
  ( echo $(date +%y%m%d) > $NVDSH_HOME/.lastUpdatedDay && askUpdate )
}

function askUpdate {
  read -q "doUpdate?Run the update?"
  echo "\n"
  if [ $doUpdate = "y" ]; then
    echo 'updating nvdsh' && syncdown
    echo 'updating apt' && update
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


#========================================= Run after reading everything
tryUpdating
