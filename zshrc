# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
#export PATH=/usr/local/bin:/usr/bin:/bin
ZSH_DISABLE_COMPFIX="true"
# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
# ZSH_THEME="agnoster"
ZSH_THEME="amuse"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
zstyle ':omz:plugins:nvm' autoload yes
plugins=(
  nvm
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"


# Enable Vim mode
bindkey -v
bindkey '^E' edit-command-line                   # Opens Vim to edit current command line

# Aliases
alias dot="cd ~/dotfiles"
alias dotv="cd ~/dotfiles && v"
alias bujo="cd ~/Box/bujo && v index.md"
alias o="cd ~/Library/Mobile\ Documents/iCloud\~md\~obsidian/Documents/MainVault/ && v +NvimTreeOpen"
alias vim="nvim"
alias v="nvim"
alias ga="git add ."
alias gc="git commit"
alias gpush="git push"
alias gpull="git pull"
alias gac="git add . && git commit"
alias tls="tmux ls"
alias tat="tmux attach-session -t "
bindkey '^R' history-incremental-search-backward
alias create-ts-repo="yarn init -y \
&& git init && \
echo node_modules > .gitignore \
&& yarn add --dev typescript jest @types/jest @swc/core @swc/jest && npx tsc --init \
&& echo 'module.exports = { \n  transform: { \n    \"^.+.(t|j)sx?$\": [\"@swc/jest\"], \n  },\n};' > jest.config.js;"

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Fix character not in range when cding into a git dir
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export ANDROID_HOME=$HOME/Library/Android/sdk export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools

alias python='python3'

# Added by serverless binary installer
export PATH="$HOME/.serverless/bin:$PATH"
source ~/dotfiles/zshignored

export EDITOR=$(which nvim)
export VISUAL=$(which nvim)

# pnpm
export PNPM_HOME="/Users/rxrossi/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm end

export DENO_INSTALL="/Users/rxrossi/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

source "$HOME/.cargo/env"

function run_go_to() { 
  source ~/dotfiles/go-to.sh
}

# Define a widget called "run_go_to", mapped to our function above.
zle -N run_go_to

# Bind it to ctrl-p
bindkey "^p" run_go_to

# TokyoNight Color Palette
    set -l foreground c0caf5
    set -l selection 283457
    set -l comment 565f89
    set -l red f7768e
    set -l orange ff9e64
    set -l yellow e0af68
    set -l green 9ece6a
    set -l purple 9d7cd8
    set -l cyan 7dcfff
    set -l pink bb9af7

    # Syntax Highlighting Colors
    set -g fish_color_normal $foreground
    set -g fish_color_command $cyan
    set -g fish_color_keyword $pink
    set -g fish_color_quote $yellow
    set -g fish_color_redirection $foreground
    set -g fish_color_end $orange
    set -g fish_color_error $red
    set -g fish_color_param $purple
    set -g fish_color_comment $comment
    set -g fish_color_selection --background=$selection
    set -g fish_color_search_match --background=$selection
    set -g fish_color_operator $green
    set -g fish_color_escape $pink
    set -g fish_color_autosuggestion $comment

    # Completion Pager Colors
    set -g fish_pager_color_progress $comment
    set -g fish_pager_color_prefix $cyan
    set -g fish_pager_color_completion $foreground
    set -g fish_pager_color_description $comment
    set -g fish_pager_color_selected_background --background=$selection

source $HOME/.developer-toolbox/developer-toolbox.sh

alias sshmatillion="cd $HOME/.ssh && ssh -i matillion_etl_key_new.pem centos@ec2-18-157-50-168.eu-central-1.compute.amazonaws.com"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/alexignez/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/alexignez/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/alexignez/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/alexignez/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

export GOPATH="$HOME/go"
export PATH="$GOPATH/bin:$PATH"

setopt nocorrectall; setopt correct

# bun completions
[ -s "/Users/alexignez/.bun/_bun" ] && source "/Users/alexignez/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
