#!/usr/bin/env sh

python3 -m pip install --user pipx
python3 -m pipx ensurepath

python -m pipx install neovim-remote

#Git repos with large files will break without this.
git config --global --add oh-my-zsh.hide-dirty 1

