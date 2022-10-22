#!/bin/sh
# To be called by MacOS Automator
export PATH=/usr/local/bin:$PATH
export PATH=/Applications/Alacritty.app/Contents/MacOS:$PATH
export PATH=/Users/rxrossi/.nvm/versions/node/v14.20.0/bin:$PATH

# alacritty="/Applications/Alacritty.app/Contents/MacOS/alacritty"
file=~/Library/Mobile\ Documents/iCloud\~md\~obsidian/Documents/MainVault/0-inbox.md

alacritty -e nvim "$file" \
  -c "norm ggO" \
  -c "norm a## $(date +%H:%M)" \
  -c "norm 2o" \
  -c "norm o---" \
  -c "norm o" \
  -c "norm 3ko" \
  -c "startinsert"
