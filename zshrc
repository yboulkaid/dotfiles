export EDITOR=nvim
export GIT_EDITOR=nvim
export CLICOLOR=1
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx
export NVIM_TUI_ENABLE_CURSOR_SHAPE=1

source ~/dotfiles/aliases

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Use pyenv to manage python versions
eval "$(pyenv init -)"

# Source fzf for fuzzy finding
export FZF_TMUX_HEIGHT=10
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
