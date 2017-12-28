#!/bin/zsh

#add to keyboard shortcuts : /usr/bin/zsh /home/nvd/.nvdsh/viewjson.sh

_SCRIPTDIR=$(cd $(dirname $0);echo $PWD)
source $_SCRIPTDIR/nvdutil.sh


viewjson &
