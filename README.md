# dotfiles

Personal configuration files managed with GNU Stow.

## Setup

Install GNU Stow:

```bash
# macOS
brew install stow

# Linux
sudo apt install stow
```

Clone and deploy:

```bash
git clone <repository-url> ~/dotfile
cd ~/dotfile
stow zsh

# Restart shell and install Zim modules
exec zsh
zimfw install
exec zsh
```

## Structure

```
dotfile/
├── zsh/
│   ├── .zshrc
│   ├── .zimrc
│   └── .config/zsh/
├── git/
└── stow/
```

## Usage

Edit configuration (changes apply via symlink):

```bash
vim ~/.zshrc
exec zsh

# Commit if everything works
cd ~/dotfile
git add -p
git commit -m "Update configuration"
git push
```

Add/remove packages:

```bash
stow packagename      # Deploy
stow -D packagename   # Remove
```

## Notes

- Use `exec zsh` to restart shell, not `source ~/.zshrc`
- Store secrets in `~/.zshrc.local` (ignored by git, automatically sourced)
- Stow creates symlinks, edits to `~/.*` files update dotfiles automatically
