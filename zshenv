#
# Defines environment variables.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Ensure that a non-login, non-interactive shell has a defined environment.
if [[ "$SHLVL" -eq 1 && ! -o LOGIN && -s "${ZDOTDIR:-$HOME}/.zprofile" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprofile"
fi

### BIOSPHERE MANAGED START ###

# Adding the "bio" executable to your path.
export PATH="/Users/youssef.boulkaid/.biosphere/core/bin:$PATH"

# Loading Biosphere's bash_profile for easier de-/activation of spheres.
[[ -s /Users/youssef.boulkaid/.biosphere/augmentations/bash_profile ]] && source /Users/youssef.boulkaid/.biosphere/augmentations/bash_profile


### BIOSPHERE MANAGED STOP ###
