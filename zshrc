export EDITOR=nvim
export VISUAL=nvim
export GIT_EDITOR=nvim
export CLICOLOR=1
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx
export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export HISTSIZE=1000
export DIRENV_LOG_FORMAT=
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"

# https://github.com/rails/rails/issues/38560
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES

# PATH additions:
# NPM packages
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
# Homebrew CBC is keg-only
export PATH="/opt/homebrew/opt/cbc/bin:$PATH"
# pip installs its binaries here. Used for AWS CLI
export PATH="$PATH:/Users/youssefboulkaid/.local/bin"
# Postgres.app
export PATH="$PATH:/Applications/Postgres.app/Contents/Versions/latest/bin"
# Custom scripts
export PATH="$PATH:$HOME/bin"


source ~/.aliases

if [[ -f $HOME/.workatorc ]]; then
  source $HOME/.workatorc
fi

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Source fzf for fuzzy finding
export FZF_TMUX_HEIGHT=10
export FZF_CTRL_R_OPTS=--sort
source <(fzf --zsh)

# Fuzzy find project and open vim
pp() {
  local dir
  dir=$(find ~/Projects -type d -maxdepth 2 | sed 's/.*Projects\///g' | fzf ) &&
  cd "$HOME/Projects/$dir"
}

bb() {
  git branch | grep -v "^\*" | fzf --height=20% --reverse --info=inline | xargs git checkout
}

setopt auto_cd
eval "$(direnv hook zsh)"

# Allow [ or ] whereever you want
# Cf. https://github.com/thoughtbot/dotfiles/pull/194
unsetopt nomatch

if [[ -f $HOME/.asdf/asdf.sh ]]; then
  source $HOME/.asdf/asdf.sh
fi

if [[ -f /opt/homebrew/opt/asdf/libexec/asdf.sh ]]; then
  source /opt/homebrew/opt/asdf/libexec/asdf.sh
fi

if [ "$TMUX" = "" ];
then tmux attach -t base || tmux new -s base
fi

# ZSH completions
fpath=(/opt/homebrew/share/zsh/site-functions $fpath)
[[ $commands[kubectl] ]] && source <(kubectl completion zsh)

# Workato:
export PATH="/opt/homebrew/opt/postgresql@11/bin:$PATH"

# instantclient
export OCI_DIR="$HOME/instantclient_12_1"
export DYLD_LIBRARY_PATH="$HOME/instantclient_12_1"
export ENV_SH_EXEC_CONTEXT=apple_silicon

# https://unix.stackexchange.com/questions/452865/are-there-any-disadvantages-of-setting-noclobber
set -o noclobber
