# dotfile

This repository stores personal configuration files, managed with GNU Stow.
Each component (zsh, stow, etc.) is placed in its own folder and symlinked into the home directory.

Usage:

1. Install Stow

   macOS: `brew install stow`

   Linux: `sudo apt install stow`

2. Clone the repository

   `git clone <your‑repo‑url> ~/dotfiles`

   `cd ~/dotfiles`

3. Stow the components you need

   `stow zsh`

   `stow stow`

Structure:

- stow/.stow-global-ignore
  Contains patterns Stow should ignore when creating symlinks.

- zsh/
  Contains zsh configuration files (for example .zshrc).

After running Stow, the files inside each component will be symlinked into your home directory.
