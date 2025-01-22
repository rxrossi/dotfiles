# Make dirs
mkdir -p  ~/.vim/undodir
mkdir -p  ~/.config/karabiner
mkdir -p  ~/.config/alacritty

# Ln
## Karabiner
ln -s -f ~/dotfiles/karabiner.json ~/.config/karabiner/karabiner.json

## TMUX
ln -s -f ~/dotfiles/tmux.conf ~/.tmux.conf

## Neovim
ln -s -f ~/dotfiles/nvim/ ~/.config/nvim

## Alacritty
ln -s -f ~/dotfiles/alacritty.toml ~/.config/alacritty.toml
ln -s -f ~/dotfiles/alacritty/ ~/.config/alacritty/

## zshrc
ln -s -f ~/dotfiles/zshrc.zshrc ~/.zshrc
