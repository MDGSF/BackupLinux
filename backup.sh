#!/bin/bash

HOME_BACKUP=$HOME/home_backup

baisc() {
  if [ ! -d "$HOME/home_backup" ];then
    echo "$HOME/home_backup 文件夹不存在，创建文件夹"
    mkdir $HOME/home_backup
  fi

  if [ ! -d "$HOME/home_backup/c1" ];then
    echo "$HOME/home_backup/c1 文件夹不存在，创建文件夹"
    mkdir -p $HOME/home_backup/c1
  fi

  cp -arf $HOME/backup.sh $HOME_BACKUP

  cp -arf $HOME/.tmux.conf $HOME_BACKUP

  cp -arf $HOME/note $HOME/home_backup
  cp -arf $HOME/.ssh $HOME/home_backup/ssh_backup

  cp -arf $HOME/local/bin/c1 $HOME/home_backup/c1/
  cp -arf $HOME/.c1 $HOME/home_backup/c1/c1_backup
  cp -arf $HOME/local/DevicesType $HOME/home_backup/

  tar -zcvf home_backup`date +"%Y%m%d%H%M%S"`.tar.gz home_backup
  rm -rf home_backup
}

vimBackup() {
  if [ ! -d "$HOME/vim_backup" ];then
    echo "$HOME/vim_backup 文件夹不存在，创建文件夹"
    mkdir $HOME/vim_backup
  fi

  cp -arf .vimrc $HOME/vim_backup/vimrc_backup
  cp -arf .vim $HOME/vim_backup/vim_backup
  tar -zcvf vim_backup`date +"%Y%m%d%H%M%S"`.tar.gz vim_backup
  rm -rf $HOME/vim_backup
}

case "$1" in
  'basic')
    baisc
    ;;
  'vim')
    vimBackup
    ;;
  *)
    echo "usage: $0 {basic|vim|restore}"
    exit 1
    ;;
esac
