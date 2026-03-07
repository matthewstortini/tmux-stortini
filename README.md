# tmux-stortini

Personal tmux configuration with automated setup.

This repository contains a tmux configuration (`tmux.conf`) and a setup
script that installs the configuration and required plugins.

## Features

- Simple tmux configuration
- Vim-style navigation between panes
- Catppuccin theme
- Plugin installation handled automatically
- Configuration stored in the repository and linked into `$HOME`

Plugins used:

- tmux-plugins/tpm
- catppuccin/tmux
- christoomey/vim-tmux-navigator

## Installation

Clone the repository and run setup:

```bash
git clone https://github.com/matthewstortini/tmux-stortini.git
cd tmux-stortini
chmod +x setup_tmux_configuration.sh
./setup_tmux_configuration.sh
