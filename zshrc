export EDITOR=nvim
export VISUAL=nvim
export GIT_EDITOR=nvim
export CLICOLOR=1
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx
export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8

# pip3 installs its binaries here. Used for AWS CLI
export PATH="$PATH:/Users/yboulkaid/.local/bin"

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
  dir=$(find ~/projects -type d -maxdepth 2 | sed 's/\/Users\/yboulkaid\/projects\///g' | fzf ) &&
  cd "/Users/yboulkaid/projects/$dir"
}

setopt auto_cd
eval "$(direnv hook zsh)"

# Allow [ or ] whereever you want
# Cf. https://github.com/thoughtbot/dotfiles/pull/194
unsetopt nomatch

source $HOME/.asdf/asdf.sh

if [ "$TMUX" = "" ]; 
then tmux attach -t base || tmux new -s base
fi
