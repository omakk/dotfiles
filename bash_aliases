#!/bin/bash

export DEV="/home/rakko/dev"
export DEV_BUILDS="${DEV}/builds"
export DEV_GIT="${DEV}/git"
export DEV_GIT_OTHER="${DEV_GIT}/other"
export DEV_GIT_RAKKO="${DEV_GIT}/rakko"
export DOTS="${DEV_GIT_RAKKO}/dotfiles"

# cd shortcuts
alias dev="cd $DEV"
alias db="cd $DEV_BUILDS"
alias dg="cd $DEV_GIT"
alias dgr="cd $DEV_GIT_RAKKO"
alias dgo="cd $DEV_GIT_OTHER"
alias dots="cd $DOTS"

# Shell
alias c=clear
alias ll="ls -lh"
alias lla="ls -lha"

# Git
alias g="git"
alias ga="g add"
alias gap="g add -p"
alias gau="g add -u"
alias gbr="g branch"
alias gba="gb --all"
alias gbd="gb -d"
alias gbD="gb -D"
alias gca="g commit --amend"
alias gcm="g commit -m"
alias gcv="g commit -v"
alias gco="g checkout"
alias gcoq="gco -q"
alias gd="g diff"
alias gds="g diff --staged"
alias gi="g init"
alias gl="g log"
alias gp="g push"
alias glo="g log --oneline"
alias glog="g log --oneline --graph"
alias gr="g rebase"
alias gs="g status"
alias curgitbranch="g symbolic-ref --short HEAD"

# Config Shortcuts
alias vim="nvim"
alias gvim="NVIM_GTK_NO_HEADERBAR=1 NVIM_GTK_NO_WINDOW_DECORATION=1 nvim-gtk"
alias vimrc="vim $DOTS/vimrc"
alias nvimrc="vimrc"
alias bashrc="vim ~/.bashrc"
alias bashaliases="vim ~/.bash_aliases"
alias kittyconf="vim ~/.config/kitty/kitty.conf"

# GPU
alias nv="__NV_PRIME_RENDER_OFFLOAD=1"
alias nvgl="__NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia"
