selected=$(find ~/emma/ ~/dotfiles/ -maxdepth 1 -type d | fzf)
cd $selected
