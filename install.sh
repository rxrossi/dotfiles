# Make dirs
mkdir -p  ~/.vim/undodir
mkdir -p  ~/.config/karabiner

# Ln
## Karabiner
ln -s -f ~/dotfiles/karabiner.json ~/.config/karabiner/karabiner.json

## TMUX
ln -s -f ~/dotfiles/tmux.conf ~/.tmux.conf

## Neovim
ln -s -f ~/dotfiles/nvim/ ~/.config/nvim

## Alacritty
ln -s -f ~/dotfiles/alacritty.yml ~/.config/alacritty.yml

## fish
ln -s -f ~/dotfiles/fish/ ~/.config/fish
