export PATH=$HOME/.nix-profile/bin:$PATH
export PATH=$HOME/bin:$HOME/.local/bin:$PATH

export ZSH="$HOME/.oh-my-zsh"
export ZSH_CUSTOM="$HOME/.oh-my-zsh-custom"

ZSH_THEME="dpoggi"

# CASE_SENSITIVE="true"
# HYPHEN_INSENSITIVE="true"

# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
DISABLE_MAGIC_FUNCTIONS="true"
# DISABLE_LS_COLORS="true"
# DISABLE_AUTO_TITLE="true"
# ENABLE_CORRECTION="true"

HIST_STAMPS="yyyy-mm-dd"

# Would you like to use another custom folder than $ZSH/custom?

plugins=(git)

source $ZSH/oh-my-zsh.sh

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

export EDITOR='vim'
export GITEDITOR='vim'

# Nix integration

nix-load() {
  local s=()
  for attr in "$@"; do
    paths=$(nix build --no-link --print-out-paths --impure --expr "(import <nixpkgs> {}).$attr")
    for p in ${(f)paths}; do
        s+=($p)
    done
  done
  for pkg in $s; do
    export PATH="$pkg/bin:$PATH"
  done
}

if [ -e $HOME/.zshrc.user ]; then
  source $HOME/.zshrc.user
fi

