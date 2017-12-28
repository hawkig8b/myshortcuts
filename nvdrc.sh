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
alias update='sudo apt-get update && sudo apt-get upgrade -y && sudo apt-get dist-upgrade ; sudo apt autoremove -y'
alias apti='sudo apt install'

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
  source nvdrc.sh ;
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

cat $NVDSH_HOME/banner.txt
