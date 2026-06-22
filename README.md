# Dotfiles

Managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Quick start

```bash
git clone https://github.com/MxDx/.dotfiles ~/.dotfiles
cd ~/.dotfiles
bash bootstrap.sh   # install packages + stow all configs
```

## dotdeps — dependency dashboard

Interactive TUI to browse, install and stow all tracked dependencies:

```bash
dotdeps
```

- `j/k` navigate · `Tab` switch pane · `→/Enter` open category · `←/Esc` back
- `i` install item · `a` install all in category · `s` stow · `n` add new dep · `r` refresh · `L` show logs · `q` quit

Logs are written to `~/.config/dotdeps/logs/` — share them when reporting issues.

## Adding a dependency

Press `n` inside dotdeps, or edit `~/.config/dotdeps/catalog.sh` directly
(symlinked from `dotdeps/.config/dotdeps/catalog.sh` in this repo).

## Stow packages

| Package   | Stows to              |
|-----------|-----------------------|
| atuin     | `~/.config/atuin/`    |
| bin       | `~/.local/bin/`       |
| dotdeps   | `~/.config/dotdeps/`  |
| hypr      | `~/.config/hypr/`     |
| nvim      | `~/.config/nvim/`     |
| p10k      | `~/.p10k.zsh`         |
| posting   | `~/.config/posting/`  |
| tmux      | `~/.tmux.conf`        |
| zshrc     | `~/.zshrc`            |

