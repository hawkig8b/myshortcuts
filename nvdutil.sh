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
  pbpaste | ppjson > $TEMPJSON &&
  xdg-open $TEMPJSON
}

#alias syncdown="gonvdsh && git pull --rebase ; cd -"
#alias syncup="gonvdsh && git add . && git commit -m 'pushing changes to master' && git push origin master; cd -"
#inputStr=$(zenity --entry --title="My Title" --text="My Text:")
#zenity --info --title="My Title" --text="Your input was: $inputStr"

function syncup {
  gonvdsh &&
  git add . &&
  commitMsg=$(zenity --entry --title="NVDSH" --text="Commit Message") &&
  git commit -m $commitMsg &&
  git push origin master ;
  cd -
}
