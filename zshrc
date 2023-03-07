export EDITOR=nvim
export VISUAL=nvim
export GIT_EDITOR=nvim
export CLICOLOR=1
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx
export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export HISTSIZE=1000
export DIRENV_LOG_FORMAT=

# https://github.com/rails/rails/issues/38560
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES

# PATH additions:
# NPM packages
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
# Homebrew CBC is keg-only
export PATH="/opt/homebrew/opt/cbc/bin:$PATH"
# pip installs its binaries here. Used for AWS CLI
export PATH="$PATH:/Users/yboulkaid/.local/bin"
# Nix
export PATH="$PATH:/nix/var/nix/profiles/default/bin/"


source ~/.aliases

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Source fzf for fuzzy finding
export FZF_TMUX_HEIGHT=10
export FZF_CTRL_R_OPTS=--sort
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Fuzzy find project and open vim
pp() {
  local dir
  dir=$(find ~/Projects -type d -maxdepth 2 | sed 's/.*Projects\///g' | fzf ) &&
  cd "$HOME/Projects/$dir"
}

setopt auto_cd
eval "$(direnv hook zsh)"

# Allow [ or ] whereever you want
# Cf. https://github.com/thoughtbot/dotfiles/pull/194
unsetopt nomatch

if [[ -f $HOME/.asdf/asdf.sh ]]; then
  source $HOME/.asdf/asdf.sh
fi

if [ "$TMUX" = "" ];
then tmux attach -t base || tmux new -s base
fi

export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
