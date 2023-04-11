#!/usr/bin/env sh

python3 -m pip install --user pipx
python3 -m pipx ensurepath

python -m pipx install neovim-remote
