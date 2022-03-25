# Make dirs
mkdir -p  ~/.vim/undodir
mkdir -p  ~/.config/nvim
mkdir -p  ~/.config/karabiner

# Ln

## Karabiner
ln -s -f ~/dotfiles/karabiner.json ~/.config/karabiner/karabiner.json

## ZSH
ln -s -f ~/dotfiles/zshrc ~/.zshrc
ln -s -f ~/dotfiles/zshenv ~/.zshenv

## TMUX
ln -s -f ~/dotfiles/tmux.conf ~/.tmux.conf

## Neovim
ln -s -f ~/dotfiles/nvim/ ~/.config/nvim

## Vim wiki on Box
ln -s -f ~/Box/vimwiki ~/vimwiki

# Box
ln -s -f ~/Library/CloudStorage/Box-Box/ ~/Box

## Alacritty
ln -s -f ~/dotfiles/alacritty.yml ~/.config/alacritty.yml
