export EDITOR=nvim
export VISUAL=nvim
export GIT_EDITOR=nvim
export CLICOLOR=1
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx
export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export HISTSIZE=1000

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
  dir=$(find ~/Projects -type d -maxdepth 2 | sed 's/\/Users\/yboulkaid\/Projects\///g' | fzf ) &&
  cd "/Users/yboulkaid/Projects/$dir"
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

export PATH="$HOME/.bin:$PATH"
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export DIRENV_LOG_FORMAT=

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/yboulkaid/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/yboulkaid/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/yboulkaid/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/yboulkaid/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

