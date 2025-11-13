#!/usr/bin/env bash
#
# Installs all dot config files and dirs by
# initing and updating submoduules and
# symlinking them to the home directory
#
# Adopted from Dave Eddy's install script,
# https://github.com/bahamas10/dotfiles/blob/master/install
#
# Date 2025-11-12
# License: MIT

symlink() {
    printf '%55s -> %s\n' "${1/#$HOME/\~}" "${2/#$HOME/\~}"
    ln -sf "$@"
}

git submodule init
git submodule update

dotfiles=(
    .vim
    .vimrc
    .bashrc
)

for f in "${dotfiles[@]}"; do 
    # remove existing
    [[ -d ~/$f && ! -L ~/$f ]] && rm -r ~/"$f"
    # link to the listed
    symlink "$PWD/$f" ~/"$f"
done
