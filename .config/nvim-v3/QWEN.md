# Neovim Configuration (LazyVim)

This directory contains a Neovim configuration based on [LazyVim](https://github.com/LazyVim/LazyVim), a modular Neovim setup powered by the [lazy.nvim](https://github.com/folke/lazy.nvim) plugin manager.

## Project Overview

This configuration provides a fully-featured Neovim environment tailored for development. It leverages LazyVim's curated set of plugins and configurations, extended with custom settings and AI integration.

*   **Core Framework:** LazyVim, which uses `lazy.nvim` for plugin management.
*   **Plugin Management:** Plugins are defined and managed via `lua/config/lazy.lua`.
*   **Customization:** Custom configurations for keymaps, options, and additional plugins are located in `lua/config/` and `lua/plugins/` respectively.
*   **AI Integration:** Includes configuration for AI coding assistants like `avante.nvim` (using Qwen) and `gp.nvim` (using Qwen via Bailian/Dashscope).

## Key Files

*   `init.lua`: The entry point for Neovim, bootstraps `lazy.nvim` and LazyVim.
*   `lua/config/lazy.lua`: Configures the `lazy.nvim` plugin manager, defines plugin specs and global settings.
*   `lua/config/keymaps.lua`: Custom Neovim key mappings.
*   `lua/plugins/ai.lua`: Configuration for AI plugins (`avante.nvim`, `gp.nvim`).
*   `lazyvim.json`: Stores LazyVim-specific settings and installed extras.

## Development Conventions

*   **Plugin Structure:** Plugins are managed by `lazy.nvim` using a specification format in `lua/config/lazy.lua`.
*   **Configuration Layers:**
    *   Default LazyVim configurations (automatically loaded).
    *   Custom configurations in `lua/config/` (keymaps, options, lazy setup).
    *   Custom plugin definitions in `lua/plugins/`.
*   **AI Setup:** AI plugins are configured to use Qwen models, with API keys expected to be set in environment variables (`OPENAI_API_KEY` for `avante.nvim`, `BAILIAN_API_KEY` for `gp.nvim`).

There are no specific build or run commands for this configuration itself, as it's a set of files for Neovim. To use it, place the contents of this directory in your Neovim config directory (typically `~/.config/nvim`) and start Neovim. `lazy.nvim` will handle plugin installation and updates on first run and subsequently.

## Usage

This configuration is intended to be used as a personal Neovim setup. After placing the files in the correct directory and launching Neovim, LazyVim will take care of setting up the environment. Key features like AI assistance are configured and ready to use (assuming API keys are set).