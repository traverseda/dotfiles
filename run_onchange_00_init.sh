#!/usr/bin/env sh

set -Eeuo pipefail

case $(uname -m) in
	"x86_64")
		nix_portable=https://github.com/DavHau/nix-portable/releases/download/v010/nix-portable
		;;
	"aarch64")
		nix_portable=https://github.com/DavHau/nix-portable/releases/download/v010/nix-portable-aarch64
esac

if ! command -v nix-shell &> /dev/null
#Check if nix already exists on this system, if it does we don't
#want to install portable nix.
then
	curl -L $nix_portable -o ~/.local/bin/nix-portable
	chmod +x ~/.local/bin/nix-portable
	ln -s ~/.local/bin/nix-portable ~/.local/bin/nix-shell
	ln -s ~/.local/bin/nix-portable ~/.local/bin/nix
fi

~/.local/bin/nix run nixpkgs#pipx install neovim-remote
~/.local/bin/nix run nixpkgs#pipx install pushbullet-cli

#Git repos with large files will break without this.
git config --global --add oh-my-zsh.hide-dirty 1

