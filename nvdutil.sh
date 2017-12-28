#!/bin/zsh

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
