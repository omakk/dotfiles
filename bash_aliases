DOTS="~/dev/git/rakko/dotfiles"
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
alias gcm="g commit -vm"
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
alias vimrc="vim $DOTS/vimrc"
alias nvimrc="vimrc"
alias bashrc="vim ~/.bashrc"
alias bashaliases="vim ~/.bash_aliases"
