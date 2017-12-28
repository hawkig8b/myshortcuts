#!/bin/zsh

NVDSH_HOME=${0:a:h}
alias gonvdsh="cd $NVDSH_HOME"

alias pbcopy="xclip -selection c"
alias pbpaste="xclip -selection clipboard -o"
alias ppjson='python -m json.tool'

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
  gonvdsh &&
  git pull --rebase &&
  source nvdutil.sh ;
  cd -
}

function syncup {
  gonvdsh &&
  git add . &&
  commitMsg=$(zenity --entry --title="NVDSH" --text="Commit Message") &&
  git commit -m $commitMsg &&
  git push origin master ;
  cd -
}
