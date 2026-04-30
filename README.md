# os-setup

Personal dotfiles + machine bootstrap, managed via [chezmoi](https://www.chezmoi.io).

## Bootstrap a new machine

```bash
sh -c "$(curl -fsLS https://raw.githubusercontent.com/apyshkin/os-setup/master/setup.sh)"
```

This installs ripgrep, Neovim (AppImage on Linux / brew on macOS), and chezmoi, then runs `chezmoi init --apply` against this repo.

## Layout

```
.
├── dot_bashrc                   → ~/.bashrc
├── dot_vimrc                    → ~/.vimrc
├── dot_config/nvim/             → ~/.config/nvim/   (LazyVim + custom plugins)
├── setup.sh                     bootstrap script
├── stylua.toml                  formatter config for nvim Lua
└── README.md
```

## Daily use

```bash
chezmoi cd              # jump into source dir
chezmoi edit ~/.bashrc  # edit + apply on save
chezmoi diff            # preview pending changes
chezmoi apply           # write source → home
chezmoi git -- pull --rebase   # sync from remote
chezmoi git -- push            # push local changes
```

## Secrets

Anything sensitive (AWS keys, tokens) lives in `~/.bash_env`, which is gitignored and **not** managed by chezmoi. `~/.bashrc` sources it if present.
