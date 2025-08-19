#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

echo -e "${CYAN}🚀 Updating local configs from repository...${NC}"

# Base directory for this repo
REPO_DIR="$(dirname "$0")/.."

echo -e "${CYAN}🚀 Updating local configs from repository...${NC}"

# Base directory for this repo
REPO_DIR="$(dirname "$0")/.."

# Create ~/.config directory if it doesn't exist
CONFIG_DIR="$HOME/.config"
if [ ! -d "$CONFIG_DIR" ]; then
    echo -e "${YELLOW}📁 Creating config directory: $CONFIG_DIR${NC}"
    mkdir -p "$CONFIG_DIR"
fi

# Copy root .zshrc if it exists
ROOT_ZSHRC="$REPO_DIR/.zshrc"
if [ -f "$ROOT_ZSHRC" ]; then
    # Backup existing .zshrc if it exists
    if [ -f "$HOME/.zshrc" ]; then
        echo -e "${YELLOW}💾 Backing up existing .zshrc to .zshrc.backup${NC}"
        cp "$HOME/.zshrc" "$HOME/.zshrc.backup"
    fi
    
    echo -e "${BLUE}🐚 Copying root .zshrc to $HOME/.zshrc${NC}"
    cp "$ROOT_ZSHRC" "$HOME/.zshrc"
    
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✅ Root .zshrc installed successfully!${NC}"
    else
        echo -e "${RED}❌ Failed to copy root .zshrc${NC}"
        exit 1
    fi
else
    echo -e "${YELLOW}⚠️  Root .zshrc not found in repository: $ROOT_ZSHRC${NC}"
fi

# Copy all contents of config directory to ~/.config
REPO_CONFIG_DIR="$REPO_DIR/config"
if [ -d "$REPO_CONFIG_DIR" ]; then
    echo -e "${BLUE}📋 Copying all config files from $REPO_CONFIG_DIR to $CONFIG_DIR${NC}"
    
    # Copy all files and directories from repo config to local config
    cp -r "$REPO_CONFIG_DIR"/* "$CONFIG_DIR/" 2>/dev/null
    
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✅ Config files copied successfully!${NC}"
    else
        echo -e "${YELLOW}⚠️  Some config files may not have been copied${NC}"
    fi
else
    echo -e "${YELLOW}⚠️  Config directory not found in repository: $REPO_CONFIG_DIR${NC}"
fi

echo -e "${CYAN}🎉 Local configs updated from repository!${NC}"
echo -e "${YELLOW}💡 Restart your terminal or run 'source ~/.zshrc' to apply changes${NC}"