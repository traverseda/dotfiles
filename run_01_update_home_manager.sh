#!/usr/bin/env bash
home-manager switch

# Check if the OS is NixOS
if grep -q 'NAME=NixOS' /etc/os-release; then
	# Get Chezmoi config as JSON

	# Check if manage_nixos setting is enabled
	manage_nixos_enabled=$(chezmoi dump-config | jq -r '.data.manage_nixos // empty')

	if [ "$manage_nixos_enabled" == "true" ]; then
		# Define paths
		local_config=~/.nix-os/configuration.nix
		system_config=/etc/nixos/configuration.nix

		# Check if the configuration file already exists
		if [ -e "$system_config" ]; then
			# Check if it's a symbolic link
			if [ -L "$system_config" ]; then
				echo "NixOS configuration is already linked."
			else
				# Rename existing configuration to .orig
				orig_file="${system_config}.orig"
				echo "Renaming existing configuration to $orig_file"
				sudo mv "$system_config" "$orig_file"

				# Create symbolic link
				sudo ln -s "$local_config" "$system_config"
				echo "NixOS configuration linked successfully."
			fi
		else
			# Create symbolic link
			sudo ln -s "$local_config" "$system_config"
			echo "NixOS configuration linked successfully."
		fi
		sudo nixos-rebuild switch
	else
		echo "Chezmoi manage_nixos setting is not enabled."
	fi
else
	echo "Not managing your nixos configuration"
fi
