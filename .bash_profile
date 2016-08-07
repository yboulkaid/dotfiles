export PATH=/usr/local/bin:~/bin:$PATH
export EDITOR=vim
export CLICOLOR=1
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx
# Run twolfson/sexy-bash-prompt
. ~/dotfiles/.fancy_git_prompt
. ~/dotfiles/.aliases 

### BIOSPHERE MANAGED START ###

# Adding the "bio" executable to your path.
export PATH="~/.biosphere/core/bin:$PATH"
# Loading Biosphere's bash_profile for easier de-/activation of spheres.
[[ -s ~/.biosphere/augmentations/bash_profile ]] && source ~/.biosphere/augmentations/bash_profile


### BIOSPHERE MANAGED STOP ###

# Bash completion
if [ -f $(brew --prefix)/etc/bash_completion ]; then
. $(brew --prefix)/etc/bash_completion
fi

# http://stackoverflow.com/questions/8616843/ctrl-s-is-not-working-as-a-horizontal-split-in-vim-when-using-commandt
stty -ixon -ixoff
