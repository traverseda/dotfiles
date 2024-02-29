#!/usr/bin/env bash
set -e

case $(uname -m) in
"x86_64")
	nix_portable=https://github.com/DavHau/nix-portable/releases/download/v010/nix-portable
	;;
"aarch64")
	nix_portable=https://github.com/DavHau/nix-portable/releases/download/v010/nix-portable-aarch64
	;;
esac

if ! command -v nix-shell &>/dev/null; then #Check if nix already exists on this system, if it does we don't
	#want to install portable nix.
	curl -L $nix_portable -o ~/.local/bin/nix-portable
	chmod +x ~/.local/bin/nix-portable
	ln -s ~/.local/bin/nix-portable ~/.local/bin/nix-shell
	ln -s ~/.local/bin/nix-portable ~/.local/bin/nix
fi

# Check if ~/.local/bin/ is in the PATH
if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
	echo 'export PATH=$HOME/.local/bin:$PATH' >>~/.bashrc
	echo 'Added ~/.local/bin/ to PATH. Please restart your terminal or run `source ~/.bashrc`.'
else
	echo 'Path already includes ~/.local/bin/. No changes needed.'
fi

source ~/.bashrc

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" || true
