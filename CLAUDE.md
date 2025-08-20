# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with
code in this repository.

## Repository Overview

This is a personal dotfiles repository that manages system configuration using
GNU Stow. The repository contains configuration for various tools and applications
organized into modular stow packages.

## Architecture

### Stow Package Structure

- `config/common_*` - Cross-platform configurations (bash, nvim, git, tmux, etc.)
- `config/osx_*` - macOS-specific configurations
- `config/wsl_*` - Windows Subsystem for Linux specific configurations

Each package follows the GNU Stow convention where the directory structure
mirrors the target home directory structure.

### Key Components

- **Makefile**: Primary interface for managing dotfile installation and bootstrapping
- **GNU Stow**: Symlink farm manager used to install/uninstall configuration packages
- **Bootstrap System**: Two-stage bootstrap process for setting up new environments

## Common Commands

### Dotfile Management

```bash
make info        # Show current environment configuration
make install     # Install all appropriate stow packages
make delete      # Remove all stow symlinks
make bootstrap   # Full system bootstrap (installs Homebrew, Stow, and all requirements)
make update      # Pull latest changes from git repository
```

### Git Operations

The `update_sources.sh` script handles git operations with automatic stashing
and conflict detection.

## Development Workflow

### Adding New Configurations

1. Create a new directory under `config/` following the naming convention:
   - `common_<name>` for cross-platform configs
   - `osx_<name>` for macOS-specific
   - `wsl_<name>` for WSL-specific
2. Mirror the home directory structure within the package
3. Run `make install` to create symlinks

### Modifying Existing Configurations

1. Edit files directly in the `config/` directories
2. Changes are immediately reflected through symlinks
3. Commit changes to git when ready

### Neovim Configuration

- Located in `config/common_nvim/.config/nvim/`
- Uses LazyVim as the base configuration
- Custom plugins defined in `lua/plugins/`
- Claude Code integration available via `coder/claudecode.nvim` plugin

## Important Notes

- The `--adopt` flag in stow commands will overwrite existing files in the home directory
- Bootstrap scripts are located in `config/common_bootstrap/bin/`
- System-specific bootstrap steps can be added to `.system-bootstrap.d/` directories

