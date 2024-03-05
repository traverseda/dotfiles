#!/usr/bin/env bash

#
# Boostrap nix package manager and home-manager
#
set -e

case $(uname -m) in
"x86_64")
	nix_portable=https://github.com/DavHau/nix-portable/releases/download/v010/nix-portable
	;;
"aarch64")
	nix_portable=https://github.com/DavHau/nix-portable/releases/download/v010/nix-portable-aarch64
	;;
esac

check_sudo() {
	if [ "$(id -u)" != "0" ]; then
		echo "This script prefers to use sudo to install nixos globally. (y/n)"
		read -r response
		if [ "$response" == "y" ] || [ "$response" == "Y" ]; then
			echo "Please enter your password for sudo commands."

			# Add your specific commands here with sudo
			sudo sh <(curl -L https://nixos.org/nix/install) --daemon

		else
			echo "Installing using nix-portable instead."
			curl -L $nix_portable -o ~/.local/bin/nix-portable
			chmod +x ~/.local/bin/nix-portable
			ln -s ~/.local/bin/nix-portable ~/.local/bin/nix-shell
			ln -s ~/.local/bin/nix-portable ~/.local/bin/nix
		fi
	fi
}

if ! command -v nix-shell &>/dev/null; then #Check if nix already exists on this system, if it does we don't
	check_sudo
fi

# Check if ~/.local/bin/ is in the PATH
if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
	echo 'export PATH=$HOME/.local/bin:$PATH' >>~/.bashrc
	echo 'Added ~/.local/bin/ to PATH. Please restart your terminal or run `source ~/.bashrc`.'
else
	echo 'Path already includes ~/.local/bin/. No changes needed.'
fi

source ~/.bashrc

nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
nix-shell '<home-manager>' -A install
