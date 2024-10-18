#!/bin/bash

echo "Setting up Hugo project..."

# Install Hugo (if not already installed)
if ! command -v hugo &> /dev/null
then
    echo "Hugo not found. Installing Hugo..."
    # For Ubuntu/Debian:
    sudo apt-get install hugo
    # For macOS (using Homebrew):
    # brew install hugo
fi

# Create Hugo site
cd website
hugo new site . --force

# Install a theme (example: Ananke theme)
git init
git submodule add https://github.com/theNewDynamic/gohugo-theme-ananke themes/ananke
echo "theme = 'ananke'" >> config.toml

echo "Setup complete!"
