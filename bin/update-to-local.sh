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

# Source and destination paths
SPACESHIP_SOURCE="$REPO_DIR/config/spaceship.zsh"
SPACESHIP_DEST="$HOME/.config/spaceship.zsh"
ZSHRC_SOURCE="$REPO_DIR/config/.zshrc"
ZSHRC_DEST="$HOME/.zshrc"

# Create ~/.config directory if it doesn't exist
CONFIG_DIR="$HOME/.config"
if [ ! -d "$CONFIG_DIR" ]; then
    echo -e "${YELLOW}📁 Creating config directory: $CONFIG_DIR${NC}"
    mkdir -p "$CONFIG_DIR"
fi

# Copy Spaceship config
if [ -f "$SPACESHIP_SOURCE" ]; then
    echo -e "${BLUE}🚀 Copying Spaceship config to $SPACESHIP_DEST${NC}"
    cp "$SPACESHIP_SOURCE" "$SPACESHIP_DEST"
    
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✅ Spaceship config installed successfully!${NC}"
    else
        echo -e "${RED}❌ Failed to copy Spaceship config${NC}"
        exit 1
    fi
else
    echo -e "${YELLOW}⚠️  Spaceship config not found in repository: $SPACESHIP_SOURCE${NC}"
fi

# Copy .zshrc
if [ -f "$ZSHRC_SOURCE" ]; then
    # Backup existing .zshrc if it exists
    if [ -f "$ZSHRC_DEST" ]; then
        echo -e "${YELLOW}💾 Backing up existing .zshrc to .zshrc.backup${NC}"
        cp "$ZSHRC_DEST" "$ZSHRC_DEST.backup"
    fi
    
    echo -e "${BLUE}🐚 Copying .zshrc to $ZSHRC_DEST${NC}"
    cp "$ZSHRC_SOURCE" "$ZSHRC_DEST"
    
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✅ .zshrc installed successfully!${NC}"
    else
        echo -e "${RED}❌ Failed to copy .zshrc${NC}"
        exit 1
    fi
else
    echo -e "${RED}❌ .zshrc not found in repository: $ZSHRC_SOURCE${NC}"
    exit 1
fi

echo -e "${CYAN}🎉 Local configs updated from repository!${NC}"
echo -e "${YELLOW}💡 Restart your terminal or run 'source ~/.zshrc' to apply changes${NC}"