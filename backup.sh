#!/bin/bash
# A simple back up script.
<<COMMENT
Author: Huang Jian
FileName: backup.sh
COMMENT

HOME_BACKUP_NAME=home_backup
HOME_BACKUP=$HOME/$HOME_BACKUP_NAME
LOCAL_DIR=$HOME/local

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
Restore_vim() {
  VIM_BACKUP=$HOME_BACKUP
  cp -arf $VIM_BACKUP/vimrc_backup $HOME/.vimrc
  cp -arf $VIM_BACKUP/vim_backup $HOME/.vim
}

Backup_profile() {
  cp -arf $HOME/.profile $HOME_BACKUP/profile_backup
}
Restore_profile() {
  cp -arf $HOME_BACKUP/profile_backup $HOME/.profile
}

Backup_go() {
  if [ ! -d "$HOME_BACKUP/go" ];then
    mkdir -p $HOME_BACKUP/go
  fi

  cp -arf $GOROOT/* $HOME_BACKUP/go
}
Restore_go() {
  if [ ! -d "$LOCAL_DIR" ];then
    mkdir -p $LOCAL_DIR
  fi

  cp -arf $HOME_BACKUP/go $LOCAL_DIR
}

Backup_cow() {
  cp -arf $HOME/.cow $HOME_BACKUP/cow_backup
}
Restore_cow() {
  cp -arf $HOME_BACKUP/cow_backup $HOME/.cow
}

Backup_git() {
  cp -arf $HOME/.gitconfig $HOME_BACKUP/gitconfig_backup
}
Restore_git() {
  cp -arf $HOME_BACKUP/gitconfig_backup $HOME/.gitconfig
}

Backup_zsh() {
  cp -arf $HOME/.zshrc $HOME_BACKUP/zshrc_backup
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
  Backup_profile
  Backup_vim
  Backup_cow
  Backup_git
  Backup_zsh

  tar -zcvf $HOME_BACKUP_NAME`date +"%Y%m%d%H%M%S"`.tar.gz -C $HOME $HOME_BACKUP_NAME
  rm -rf $HOME_BACKUP
}

api_Backup_development_environment() {
  if [ ! -d "$HOME_BACKUP" ];then
    echo "$HOME_BACKUP 文件夹不存在，创建文件夹"
    mkdir -p $HOME_BACKUP
  fi

  Backup_tmux
  Backup_vim
  Backup_git
  Backup_go 

  tar -zcvf $HOME_BACKUP_NAME`date +"%Y%m%d%H%M%S"`.tar.gz -C $HOME $HOME_BACKUP_NAME
  rm -rf $HOME_BACKUP
}

case "$1" in
  'backup_vim')
    Backup_vim
    ;;
  'backup_basic')
    api_baisc
    ;;
  'backup_dev')
    api_Backup_development_environment
    ;;
  *)
    echo "usage: $0 {backup_vim|backup_basic|backup_dev}"
    exit 1
    ;;
esac


