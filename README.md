After a certain point I probably should just move to vscode, but the nice thing
about vim is that it fits itself to my pre-existing workflows, not the other way around

These dotfiles are managed by chezmoi.

    sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply traverseda

Executables are managed by nix-portable, and downloaded on-demand. This will only work on
x86_64 and aarch64 OSs. Also apparently not termux.
