# tmux-stortini

Personal tmux configuration with automated setup, designed to work especially well with:

- https://github.com/matthewstortini/nvim-stortini
- https://github.com/matthewstortini/wezterm-stortini

This repository contains a `tmux.conf` and a setup script that installs the configuration and required plugins. The setup script symlinks `~/.tmux.conf` to the repository `tmux.conf`, creates a local `plugins/` directory inside the repository, installs or updates plugin clones there, and then symlinks them into `~/.tmux/plugins/`. That means you can edit the repository `tmux.conf` directly and reload tmux without needing to recopy the file.

---

## Features

- Prefix rebound from the tmux default to `Ctrl-s` (`C-s`)
- Efficient pane switching with Vim-style directional bindings:
  - `Ctrl-h` move left
  - `Ctrl-j` move down
  - `Ctrl-k` move up
  - `Ctrl-l` move right
- Efficient pane resizing without a prefix:
  - `Alt-h` resize left by 5
  - `Alt-j` resize down by 5
  - `Alt-k` resize up by 5
  - `Alt-l` resize right by 5
- Reload binding:
  - `prefix + r` reloads `~/.tmux.conf` and shows a confirmation message
- Catppuccin-themed status line with a minimal layout
- Plugin installation handled automatically by the setup script

---

## Plugins

This configuration currently uses three tmux plugins:

- `tmux-plugins/tpm`  
  TPM (Tmux Plugin Manager). This is the plugin manager responsible for loading and managing the other tmux plugins. The config finishes by running TPM from `~/.tmux/plugins/tpm/tpm`. 

- `catppuccin/tmux`  
  Provides the Catppuccin theme and status line integration. This config uses it to build the right side of the status line and customize window text styling and colors.

- `christoomey/vim-tmux-navigator`  
  Intended for smoother navigation between tmux panes and Neovim splits in a shared workflow with the companion Neovim config. It is installed through TPM like the other plugins.

---

## Installation

Clone the repository and run setup:

```bash
git clone git@github.com:matthewstortini/tmux-stortini.git
cd tmux-stortini
chmod +x setup_tmux_configuration.sh
./setup_tmux_configuration.sh
```

The setup script will:

1. Symlink `~/.tmux.conf` to the repository `tmux.conf`
2. Create a repository-local `plugins/` directory if needed
3. Create `~/.tmux/plugins/` if needed
4. Clone or update each plugin listed in `tmux.conf`
5. Symlink each plugin from the repository `plugins/` directory into `~/.tmux/plugins/`

After setup, activate or reload the config with:

```bash
tmux source-file ~/.tmux.conf
```

If tmux is not already running, just start tmux normally and it will read `~/.tmux.conf` on startup.

---

## Editing the configuration

Because `~/.tmux.conf` is a symlink to the repository file created by the setup script, you can edit the repository `tmux.conf` directly. After saving changes, reload tmux with:

- `prefix + r`, or
- `tmux source-file ~/.tmux.conf` 

---

## Tmux cheat sheet

### Starting and attaching

- Start a new tmux session:
  ```bash
  tmux
  ```

- Start a new named session:
  ```bash
  tmux new -s mysession
  ```

- Attach to the most recent session:
  ```bash
  tmux attach
  ```

- Attach to a specific named session:
  ```bash
  tmux attach -t mysession
  ```

- List sessions:
  ```bash
  tmux ls
  ```

- Detach from session  
  `prefix + d`

---

### Renaming and killing sessions

- Rename the current session
  ```bash
  tmux rename-session newname
  ```

- Kill a specific session
  ```bash
  tmux kill-session -t mysession
  ```

- Kill all sessions / stop tmux server
  ```bash
  tmux kill-server
  ```

---

### Windows

- Create a new window  
  `prefix + c`

- Rename the current window  
  `prefix + ,`

- List all windows  
  `prefix + w`

- Switch to window by number  
  `prefix + 0` through `prefix + 9`

- Move to next window  
  `prefix + n`

- Move to previous window  
  `prefix + p`

- Close current window  
  `prefix + &`

- Move current window to a new index  
  `prefix + .`

- Swap two windows
  ```
  prefix + :swap-window -s <source-window-number> -t <target-window-number>
  ```

---

### Panes

- Split horizontally (top / bottom)  
  `prefix + "`

- Split vertically (left / right)  
  `prefix + %`

- Move between panes  
  `Ctrl-h`  
  `Ctrl-j`  
  `Ctrl-k`  
  `Ctrl-l`

- Resize panes  
  `Alt-h`  
  `Alt-j`  
  `Alt-k`  
  `Alt-l`

- Close current pane  
  `prefix + x`

- Convert pane into a new window  
  `prefix + !`

- Show pane numbers (quick pane selection)  
  `prefix + q`

- Toggle pane zoom  
  `prefix + z`

---

### Reloading config

- Reload tmux config from inside tmux  
  `prefix + r`

---

## Notes

This setup is designed to stay simple:

- the repository `tmux.conf` is the source of truth
- `~/.tmux.conf` points to it
- repository-local plugin clones live in `plugins/`
- `~/.tmux/plugins/` points to those clones

That keeps the configuration easy to edit, easy to reinstall, and easy to keep in sync across machines.
