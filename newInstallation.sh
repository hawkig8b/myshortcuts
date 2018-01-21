#!/bin/zsh

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


function no_password_for_updates {
  LINE="$USER ALL= NOPASSWD: /usr/sbin/synaptic, /usr/bin/software-center, /usr/bin/apt-get, /usr/bin/apt"
  echo $LINE | sudo tee -a /etc/sudoers > /dev/null
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

install_apps
