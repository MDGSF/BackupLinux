#!/bin/bash

HOME_BACKUP=$HOME/home_backup

Backup_c1() {
  if [ ! -d "$HOME_BACKUP/c1" ];then
    echo "$HOME_BACKUP/c1 文件夹不存在，创建文件夹"
    mkdir -p $HOME_BACKUP/c1
  fi

  cp -arf $HOME/local/bin/c1 $HOME_BACKUP/c1/
  cp -arf $HOME/.c1 $HOME_BACKUP/c1/c1_backup
  cp -arf $HOME/local/DevicesType $HOME_BACKUP/
}

Restore_c1() {
  echo ""
}

Backup_note() {
  cp -arf $HOME/note $HOME_BACKUP/note_backup
}
Restore_note() {
  cp -arf $HOME_BACKUP/note_backup $HOME/note
}

Backup_ssh() {
  cp -arf $HOME/.ssh $HOME_BACKUP/ssh_backup
}
Restore_ssh() {
  cp -arf $HOME_BACKUP/ssh_backup $HOME/.ssh
}

Backup_tmux() {
  cp -arf $HOME/.tmux.conf $HOME_BACKUP/tmux.conf.backup
}
Restore_tmux() {
  cp -arf $HOME_BACKUP/tmux.conf.backup $HOME/.tmux.conf
}

Backup_vim() {
  VIM_BACKUP=$HOME_BACKUP
  if [ ! -d "$VIM_BACKUP" ];then
    echo "$VIM_BACKUP 文件夹不存在，创建文件夹"
    mkdir -p $VIM_BACKUP
  fi

  cp -arf $HOME/.vimrc $VIM_BACKUP/vimrc_backup
  cp -arf $HOME/.vim $VIM_BACKUP/vim_backup
}

api_baisc() {
  if [ ! -d "$HOME_BACKUP" ];then
    echo "$HOME_BACKUP 文件夹不存在，创建文件夹"
    mkdir -p $HOME_BACKUP
  fi

  Backup_c1
  Backup_note
  Backup_ssh
  Backup_tmux
  Backup_vim

  tar -zcvf home_backup`date +"%Y%m%d%H%M%S"`.tar.gz $HOME_BACKUP
  rm -rf $HOME_BACKUP
}

api_Backup_development_environment() {
  echo ""
}

case "$1" in
  'basic')
    api_baisc
    ;;
  'vim')
    ;;
  'dev')
    api_Backup_development_environment
    ;;
  *)
    echo "usage: $0 {basic|vim|restore}"
    exit 1
    ;;
esac


