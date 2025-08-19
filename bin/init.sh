#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
NC='\033[0m' # No Color

# ASCII Art
echo -e "${CYAN}"
cat << "EOF"
 ██████╗ ██████╗ ███╗   ██╗███████╗██╗ ██████╗ 
██╔════╝██╔═══██╗████╗  ██║██╔════╝██║██╔════╝ 
██║     ██║   ██║██╔██╗ ██║█████╗  ██║██║  ███╗
██║     ██║   ██║██║╚██╗██║██╔══╝  ██║██║   ██║
╚██████╗╚██████╔╝██║ ╚████║██║     ██║╚██████╔╝
 ╚═════╝ ╚═════╝ ╚═╝  ╚═══╝╚═╝     ╚═╝ ╚═════╝ 
                                                
    ███████╗███████╗████████╗██╗   ██╗██████╗  
    ██╔════╝██╔════╝╚══██╔══╝██║   ██║██╔══██╗ 
    ███████╗█████╗     ██║   ██║   ██║██████╔╝ 
    ╚════██║██╔══╝     ██║   ██║   ██║██╔═══╝  
    ███████║███████╗   ██║   ╚██████╔╝██║      
    ╚══════╝╚══════╝   ╚═╝    ╚═════╝ ╚═╝      
EOF
echo -e "${NC}"

echo -e "${PURPLE}🚀 Welcome to the Config Files Setup! 🚀${NC}"
echo -e "${YELLOW}✨ Let's make your terminal awesome! ✨${NC}"
echo ""

# Check if Oh My Zsh is already installed
if [ -d "$HOME/.oh-my-zsh" ]; then
    echo -e "${GREEN}🎉 Oh My Zsh is already installed!${NC}"
else
    echo -e "${BLUE}📦 Installing Oh My Zsh...${NC}"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✅ Oh My Zsh installed successfully!${NC}"
    else
        echo -e "${RED}❌ Failed to install Oh My Zsh${NC}"
        exit 1
    fi
fi

# Install Fira Code Nerd Font
echo -e "${BLUE}🔤 Installing Fira Code Nerd Font...${NC}"

# Check if font is already installed (macOS)
if [[ "$OSTYPE" == "darwin"* ]]; then
    FONT_DIR="$HOME/Library/Fonts"
    if ls "$FONT_DIR"/FiraCode* &> /dev/null; then
        echo -e "${GREEN}✅ Fira Code Nerd Font is already installed!${NC}"
    else
        echo -e "${YELLOW}📥 Downloading Fira Code Nerd Font...${NC}"
        
        # Create temp directory
        TEMP_DIR=$(mktemp -d)
        cd "$TEMP_DIR"
        
        # Download the font
        curl -fLo "FiraCode.zip" https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/FiraCode.zip
        
        if [ $? -eq 0 ]; then
            echo -e "${YELLOW}📦 Extracting font files...${NC}"
            unzip -q FiraCode.zip
            
            # Install font files
            mkdir -p "$FONT_DIR"
            cp *.ttf "$FONT_DIR/" 2>/dev/null || true
            
            echo -e "${GREEN}✅ Fira Code Nerd Font installed successfully!${NC}"
            echo -e "${CYAN}💡 You may need to restart your terminal and select 'FiraCode Nerd Font' in your terminal preferences${NC}"
        else
            echo -e "${RED}❌ Failed to download Fira Code Nerd Font${NC}"
        fi
        
        # Cleanup
        cd - > /dev/null
        rm -rf "$TEMP_DIR"
    fi
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    FONT_DIR="$HOME/.local/share/fonts"
    if ls "$FONT_DIR"/FiraCode* &> /dev/null 2>&1; then
        echo -e "${GREEN}✅ Fira Code Nerd Font is already installed!${NC}"
    else
        echo -e "${YELLOW}📥 Downloading Fira Code Nerd Font...${NC}"
        
        # Create temp directory
        TEMP_DIR=$(mktemp -d)
        cd "$TEMP_DIR"
        
        # Download the font
        curl -fLo "FiraCode.zip" https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/FiraCode.zip
        
        if [ $? -eq 0 ]; then
            echo -e "${YELLOW}📦 Extracting font files...${NC}"
            unzip -q FiraCode.zip
            
            # Install font files
            mkdir -p "$FONT_DIR"
            cp *.ttf "$FONT_DIR/" 2>/dev/null || true
            
            # Refresh font cache
            fc-cache -fv > /dev/null 2>&1
            
            echo -e "${GREEN}✅ Fira Code Nerd Font installed successfully!${NC}"
            echo -e "${CYAN}💡 You may need to restart your terminal and select 'FiraCode Nerd Font' in your terminal preferences${NC}"
        else
            echo -e "${RED}❌ Failed to download Fira Code Nerd Font${NC}"
        fi
        
        # Cleanup
        cd - > /dev/null
        rm -rf "$TEMP_DIR"
    fi
else
    echo -e "${YELLOW}⚠️  Font installation not supported on this OS. Please install Fira Code Nerd Font manually.${NC}"
fi

# Install Spaceship prompt
echo -e "${BLUE}🚀 Installing Spaceship prompt...${NC}"

# Set ZSH_CUSTOM if not already set
if [ -z "$ZSH_CUSTOM" ]; then
    ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"
fi

# Check if Spaceship is already installed
if [ -d "$ZSH_CUSTOM/themes/spaceship-prompt" ]; then
    echo -e "${GREEN}✅ Spaceship prompt is already installed!${NC}"
else
    echo -e "${YELLOW}📥 Cloning Spaceship prompt repository...${NC}"
    
    # Clone the repository
    git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
    
    if [ $? -eq 0 ]; then
        echo -e "${YELLOW}🔗 Creating symlink...${NC}"
        
        # Create symlink
        ln -sf "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
        
        if [ $? -eq 0 ]; then
            echo -e "${GREEN}✅ Spaceship prompt installed successfully!${NC}"
            
            # Update .zshrc to use spaceship theme
            if [ -f "$HOME/.zshrc" ]; then
                echo -e "${YELLOW}⚙️  Setting Spaceship as default theme...${NC}"
                
                # Check if ZSH_THEME is already set to spaceship
                if grep -q 'ZSH_THEME="spaceship"' "$HOME/.zshrc"; then
                    echo -e "${GREEN}✅ Spaceship theme is already set in .zshrc!${NC}"
                else
                    # Replace existing ZSH_THEME or add it
                    if grep -q '^ZSH_THEME=' "$HOME/.zshrc"; then
                        sed -i.bak 's/^ZSH_THEME=.*/ZSH_THEME="spaceship"/' "$HOME/.zshrc"
                    else
                        echo 'ZSH_THEME="spaceship"' >> "$HOME/.zshrc"
                    fi
                    echo -e "${GREEN}✅ Updated .zshrc to use Spaceship theme!${NC}"
                fi
            else
                echo -e "${YELLOW}⚠️  .zshrc not found. You'll need to set ZSH_THEME=\"spaceship\" manually.${NC}"
            fi
        else
            echo -e "${RED}❌ Failed to create symlink for Spaceship theme${NC}"
        fi
    else
        echo -e "${RED}❌ Failed to clone Spaceship prompt repository${NC}"
    fi
fi

# Set zsh as default shell
echo -e "${BLUE}🐚 Setting zsh as default shell...${NC}"

# Check if zsh is available
if ! command -v zsh &> /dev/null; then
    echo -e "${RED}❌ zsh is not installed. Please install zsh first.${NC}"
    exit 1
fi

# Get the path to zsh
ZSH_PATH=$(which zsh)

# Check if zsh is already the default shell
if [ "$SHELL" = "$ZSH_PATH" ]; then
    echo -e "${GREEN}🎯 zsh is already your default shell!${NC}"
else
    # Add zsh to /etc/shells if not already there
    if ! grep -q "$ZSH_PATH" /etc/shells; then
        echo -e "${YELLOW}📝 Adding zsh to /etc/shells...${NC}"
        echo "$ZSH_PATH" | sudo tee -a /etc/shells > /dev/null
    fi
    
    # Change default shell
    echo -e "${YELLOW}🔄 Changing default shell to zsh...${NC}"
    chsh -s "$ZSH_PATH"
    
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✅ Default shell changed to zsh!${NC}"
        echo -e "${CYAN}💡 Please restart your terminal or run 'exec zsh' to start using zsh${NC}"
    else
        echo -e "${RED}❌ Failed to change default shell${NC}"
        exit 1
    fi
fi

echo ""
echo -e "${PURPLE}🎊 Setup complete! Your terminal is now ready to rock! 🎊${NC}"

# Run update-to-local script to apply any saved configs
SCRIPT_DIR="$(dirname "$0")"
UPDATE_SCRIPT="$SCRIPT_DIR/update-to-local.sh"

if [ -f "$UPDATE_SCRIPT" ]; then
    echo -e "${BLUE}📋 Applying saved configurations...${NC}"
    "$UPDATE_SCRIPT"
else
    echo -e "${YELLOW}⚠️  No saved configurations found to apply${NC}"
fi

echo -e "${CYAN}🌟 Enjoy your enhanced shell experience! 🌟${NC}"
echo ""