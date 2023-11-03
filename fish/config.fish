if status is-interactive
    # Commands to run in interactive sessions can go here
end

fish_vi_key_bindings
# fish_default_key_bindings

alias v="nvim"

# set -U fish_greeting

set -gx PATH /Library/PostgreSQL/16/bin $PATH

#!/bin/bash
set -Ua fish_user_paths $HOME/.cargo/bin

# Show the full path instead of a single letter
set fish_prompt_pwd_dir_length 0

