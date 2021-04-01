# Make dirs
mkdir -p  ~/.vim/undodir

## Karabiner
mkdir -p ~/.config/karabiner
ln -s -f ~/dotfiles/karabiner.json ~/.config/karabiner/karabiner.json

## ZSH
ln -s -f ~/dotfiles/zshrc ~/.zshrc
ln -s -f ~/dotfiles/zshenv ~/.zshenv

## TMUX
ln -s -f ~/dotfiles/tmux.conf ~/.tmux.conf

## Neovim
ln -s -f ~/dotfiles/nvim/ ~/.config

ln -s -f ~/dotfiles/nvim/ultisnips/ ~/.config/coc

## Alacritty
ln -s -f ~/dotfiles/alacritty.yml ~/.config/alacritty.yml

## Vim wiki on Box
ln -s -f ~/Box/vimwiki ~/vimwiki
