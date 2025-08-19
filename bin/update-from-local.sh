#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

echo -e "${CYAN}🚀 Updating configs from local system...${NC}"

# Base directory for this repo
REPO_DIR="$(dirname "$0")/.."

# Create config directory if it doesn't exist
CONFIG_DIR="$REPO_DIR/config"
if [ ! -d "$CONFIG_DIR" ]; then
    echo -e "${YELLOW}📁 Creating config directory: $CONFIG_DIR${NC}"
    mkdir -p "$CONFIG_DIR"
fi

# Copy root .zshrc if it exists
ZSHRC_SOURCE="$HOME/.zshrc"
ZSHRC_DEST="$REPO_DIR/.zshrc"
if [ -f "$ZSHRC_SOURCE" ]; then
    echo -e "${BLUE}🐚 Copying .zshrc from $ZSHRC_SOURCE${NC}"
    cp "$ZSHRC_SOURCE" "$ZSHRC_DEST"
    
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✅ .zshrc updated successfully!${NC}"
    else
        echo -e "${RED}❌ Failed to copy .zshrc${NC}"
        exit 1
    fi
else
    echo -e "${RED}❌ .zshrc not found: $ZSHRC_SOURCE${NC}"
    exit 1
fi

# Copy Spaceship config
SPACESHIP_SOURCE="$HOME/.config/spaceship.zsh"
SPACESHIP_DEST="$CONFIG_DIR/spaceship.zsh"
if [ -f "$SPACESHIP_SOURCE" ]; then
    echo -e "${BLUE}🚀 Copying Spaceship config from $SPACESHIP_SOURCE${NC}"
    cp "$SPACESHIP_SOURCE" "$SPACESHIP_DEST"
    
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✅ Spaceship config updated successfully!${NC}"
    else
        echo -e "${RED}❌ Failed to copy Spaceship config${NC}"
        exit 1
    fi
else
    echo -e "${YELLOW}⚠️  Spaceship config not found: $SPACESHIP_SOURCE${NC}"
fi

# Copy nvim config if it exists
NVIM_SOURCE="$HOME/.config/nvim"
NVIM_DEST="$CONFIG_DIR/nvim"
if [ -d "$NVIM_SOURCE" ]; then
    echo -e "${BLUE}⚡ Copying nvim config from $NVIM_SOURCE${NC}"
    
    # Remove existing nvim config in repo if it exists
    if [ -d "$NVIM_DEST" ]; then
        rm -rf "$NVIM_DEST"
    fi
    
    # Copy the entire nvim directory
    cp -r "$NVIM_SOURCE" "$NVIM_DEST"
    
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✅ nvim config copied successfully!${NC}"
    else
        echo -e "${RED}❌ Failed to copy nvim config${NC}"
        exit 1
    fi
else
    echo -e "${YELLOW}⚠️  nvim config not found: $NVIM_SOURCE${NC}"
fi

echo -e "${CYAN}📄 Configs saved to: $CONFIG_DIR${NC}"