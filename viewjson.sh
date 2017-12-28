#!/bin/zsh

#add to keyboard shortcuts : /usr/bin/zsh /home/nvd/.nvdsh/viewjson.sh

alias pbcopy="xclip -selection c"
alias pbpaste="xclip -selection clipboard -o"
alias ppjson='python -m json.tool'
alias viewjson='TEMPJSON=$(mktemp).json && pbpaste | ppjson > $TEMPJSON && xdg-open $TEMPJSON'

viewjson

[[ $? -eq 0  ]] || zenity \
--error \
--text="Error Processing Json" \
--title="ViewJson" \
