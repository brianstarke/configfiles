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
                   ___                                      
                  <___>                                     
     __       ,--'```) (```'--.       __                      
    //\\ _,-;' `--._______,--' `:-._ //\\    
    \\ ;'  ;                     :  `: //                     
     `(   ;                       :   )'     
       :.(                         ),;       
        `.`--.___           ___.--','                         
          `.     ``-------''     ,'                           
             -.               ,-                              
               `-._______.-'
EOF
echo -e "${NC}"

echo -e "${RED}🔥 ${YELLOW}TERMINAL ${GREEN}SETUP ${BLUE}WIZARD ${PURPLE}🔥${NC}"
echo -e "${CYAN}✨ Let's make your terminal absolutely legendary! ✨${NC}"
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

# Install zsh-autosuggestions
echo -e "${BLUE}🔮 Installing zsh-autosuggestions...${NC}"

# Set ZSH_CUSTOM if not already set
if [ -z "$ZSH_CUSTOM" ]; then
    ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"
fi

# Check if zsh-autosuggestions is already installed
if [ -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
    echo -e "${GREEN}✅ zsh-autosuggestions is already installed!${NC}"
else
    echo -e "${YELLOW}📥 Cloning zsh-autosuggestions repository...${NC}"
    
    # Clone the repository
    git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
    
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✅ zsh-autosuggestions installed successfully!${NC}"
        echo -e "${CYAN}💡 Add 'zsh-autosuggestions' to your plugins list in .zshrc${NC}"
    else
        echo -e "${RED}❌ Failed to clone zsh-autosuggestions repository${NC}"
    fi
fi

# Install zsh-syntax-highlighting
echo -e "${BLUE}🎨 Installing zsh-syntax-highlighting...${NC}"

# Check if zsh-syntax-highlighting is already installed
if [ -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
    echo -e "${GREEN}✅ zsh-syntax-highlighting is already installed!${NC}"
else
    echo -e "${YELLOW}📥 Cloning zsh-syntax-highlighting repository...${NC}"
    
    # Clone the repository
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
    
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✅ zsh-syntax-highlighting installed successfully!${NC}"
        echo -e "${CYAN}💡 Add 'zsh-syntax-highlighting' to your plugins list in .zshrc${NC}"
    else
        echo -e "${RED}❌ Failed to clone zsh-syntax-highlighting repository${NC}"
    fi
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

# Install lazygit and ripgrep
echo -e "${BLUE}⚡ Installing development tools (lazygit, ripgrep, eza, fzf, zoxide)...${NC}"

# Detect package manager and install tools
if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS - check for Homebrew
    if command -v brew &> /dev/null; then
        echo -e "${YELLOW}🍺 Using Homebrew to install tools...${NC}"
        
        # Install lazygit
        if command -v lazygit &> /dev/null; then
            echo -e "${GREEN}✅ lazygit is already installed!${NC}"
        else
            echo -e "${YELLOW}📦 Installing lazygit...${NC}"
            brew install lazygit
            if [ $? -eq 0 ]; then
                echo -e "${GREEN}✅ lazygit installed successfully!${NC}"
            else
                echo -e "${RED}❌ Failed to install lazygit${NC}"
            fi
        fi
        
        # Install ripgrep
        if command -v rg &> /dev/null; then
            echo -e "${GREEN}✅ ripgrep is already installed!${NC}"
        else
            echo -e "${YELLOW}📦 Installing ripgrep...${NC}"
            brew install ripgrep
            if [ $? -eq 0 ]; then
                echo -e "${GREEN}✅ ripgrep installed successfully!${NC}"
            else
                echo -e "${RED}❌ Failed to install ripgrep${NC}"
            fi
        fi
        
        # Install eza
        if command -v eza &> /dev/null; then
            echo -e "${GREEN}✅ eza is already installed!${NC}"
        else
            echo -e "${YELLOW}📦 Installing eza...${NC}"
            brew install eza
            if [ $? -eq 0 ]; then
                echo -e "${GREEN}✅ eza installed successfully!${NC}"
            else
                echo -e "${RED}❌ Failed to install eza${NC}"
            fi
        fi
        
        # Install fzf
        if command -v fzf &> /dev/null; then
            echo -e "${GREEN}✅ fzf is already installed!${NC}"
        else
            echo -e "${YELLOW}📦 Installing fzf...${NC}"
            brew install fzf
            if [ $? -eq 0 ]; then
                echo -e "${GREEN}✅ fzf installed successfully!${NC}"
                echo -e "${CYAN}💡 Run 'fzf --install' to set up key bindings and completion${NC}"
            else
                echo -e "${RED}❌ Failed to install fzf${NC}"
            fi
        fi
        
        # Install zoxide
        if command -v zoxide &> /dev/null; then
            echo -e "${GREEN}✅ zoxide is already installed!${NC}"
        else
            echo -e "${YELLOW}📦 Installing zoxide...${NC}"
            brew install zoxide
            if [ $? -eq 0 ]; then
                echo -e "${GREEN}✅ zoxide installed successfully!${NC}"
                echo -e "${CYAN}💡 Add 'eval \"\$(zoxide init zsh)\"' to your .zshrc${NC}"
            else
                echo -e "${RED}❌ Failed to install zoxide${NC}"
            fi
        fi
    else
        echo -e "${YELLOW}⚠️  Homebrew not found. Please install Homebrew first or install lazygit and ripgrep manually.${NC}"
    fi
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    # Linux - try different package managers
    if command -v apt &> /dev/null; then
        echo -e "${YELLOW}📦 Using apt to install tools...${NC}"
        
        # Update package list
        sudo apt update
        
        # Install lazygit
        if command -v lazygit &> /dev/null; then
            echo -e "${GREEN}✅ lazygit is already installed!${NC}"
        else
            echo -e "${YELLOW}📦 Installing lazygit...${NC}"
            # lazygit might not be in default repos, try snap or manual install
            if command -v snap &> /dev/null; then
                sudo snap install lazygit
            else
                echo -e "${YELLOW}⚠️  lazygit not available via apt. Please install manually from: https://github.com/jesseduffield/lazygit${NC}"
            fi
        fi
        
        # Install ripgrep
        if command -v rg &> /dev/null; then
            echo -e "${GREEN}✅ ripgrep is already installed!${NC}"
        else
            echo -e "${YELLOW}📦 Installing ripgrep...${NC}"
            sudo apt install -y ripgrep
        fi
        
        # Install eza
        if command -v eza &> /dev/null; then
            echo -e "${GREEN}✅ eza is already installed!${NC}"
        else
            echo -e "${YELLOW}📦 Installing eza...${NC}"
            # eza might not be in default repos, try from GitHub releases
            wget -qO- https://github.com/eza-community/eza/releases/latest/download/eza_x86_64-unknown-linux-gnu.tar.gz | sudo tar xz -C /usr/local/bin
            if [ $? -eq 0 ]; then
                echo -e "${GREEN}✅ eza installed successfully!${NC}"
            else
                echo -e "${YELLOW}⚠️  Failed to install eza. Please install manually from: https://github.com/eza-community/eza${NC}"
            fi
        fi
        
        # Install fzf
        if command -v fzf &> /dev/null; then
            echo -e "${GREEN}✅ fzf is already installed!${NC}"
        else
            echo -e "${YELLOW}📦 Installing fzf...${NC}"
            sudo apt install -y fzf
            if [ $? -eq 0 ]; then
                echo -e "${GREEN}✅ fzf installed successfully!${NC}"
            else
                echo -e "${RED}❌ Failed to install fzf${NC}"
            fi
        fi
        
        # Install zoxide
        if command -v zoxide &> /dev/null; then
            echo -e "${GREEN}✅ zoxide is already installed!${NC}"
        else
            echo -e "${YELLOW}📦 Installing zoxide...${NC}"
            curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
            if [ $? -eq 0 ]; then
                echo -e "${GREEN}✅ zoxide installed successfully!${NC}"
                echo -e "${CYAN}💡 Add 'eval \"\$(zoxide init zsh)\"' to your .zshrc${NC}"
            else
                echo -e "${RED}❌ Failed to install zoxide${NC}"
            fi
        fi
        
    elif command -v yum &> /dev/null; then
        echo -e "${YELLOW}📦 Using yum to install tools...${NC}"
        
        # Install ripgrep
        if command -v rg &> /dev/null; then
            echo -e "${GREEN}✅ ripgrep is already installed!${NC}"
        else
            echo -e "${YELLOW}📦 Installing ripgrep...${NC}"
            sudo yum install -y ripgrep
        fi
        
        # Install eza
        if command -v eza &> /dev/null; then
            echo -e "${GREEN}✅ eza is already installed!${NC}"
        else
            echo -e "${YELLOW}⚠️  Please install eza manually from: https://github.com/eza-community/eza${NC}"
        fi
        
        # Install fzf
        if command -v fzf &> /dev/null; then
            echo -e "${GREEN}✅ fzf is already installed!${NC}"
        else
            echo -e "${YELLOW}📦 Installing fzf...${NC}"
            sudo yum install -y fzf
            if [ $? -eq 0 ]; then
                echo -e "${GREEN}✅ fzf installed successfully!${NC}"
            else
                echo -e "${RED}❌ Failed to install fzf${NC}"
            fi
        fi
        
        # Install zoxide
        if command -v zoxide &> /dev/null; then
            echo -e "${GREEN}✅ zoxide is already installed!${NC}"
        else
            echo -e "${YELLOW}📦 Installing zoxide...${NC}"
            curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
            if [ $? -eq 0 ]; then
                echo -e "${GREEN}✅ zoxide installed successfully!${NC}"
                echo -e "${CYAN}💡 Add 'eval \"\$(zoxide init zsh)\"' to your .zshrc${NC}"
            else
                echo -e "${RED}❌ Failed to install zoxide${NC}"
            fi
        fi
        
        echo -e "${YELLOW}⚠️  Please install lazygit manually from: https://github.com/jesseduffield/lazygit${NC}"
        
    elif command -v pacman &> /dev/null; then
        echo -e "${YELLOW}📦 Using pacman to install tools...${NC}"
        
        # Install lazygit
        if command -v lazygit &> /dev/null; then
            echo -e "${GREEN}✅ lazygit is already installed!${NC}"
        else
            echo -e "${YELLOW}📦 Installing lazygit...${NC}"
            sudo pacman -S --noconfirm lazygit
        fi
        
        # Install ripgrep
        if command -v rg &> /dev/null; then
            echo -e "${GREEN}✅ ripgrep is already installed!${NC}"
        else
            echo -e "${YELLOW}📦 Installing ripgrep...${NC}"
            sudo pacman -S --noconfirm ripgrep
        fi
        
        # Install eza
        if command -v eza &> /dev/null; then
            echo -e "${GREEN}✅ eza is already installed!${NC}"
        else
            echo -e "${YELLOW}📦 Installing eza...${NC}"
            sudo pacman -S --noconfirm eza
        fi
        
        # Install fzf
        if command -v fzf &> /dev/null; then
            echo -e "${GREEN}✅ fzf is already installed!${NC}"
        else
            echo -e "${YELLOW}📦 Installing fzf...${NC}"
            sudo pacman -S --noconfirm fzf
            if [ $? -eq 0 ]; then
                echo -e "${GREEN}✅ fzf installed successfully!${NC}"
            else
                echo -e "${RED}❌ Failed to install fzf${NC}"
            fi
        fi
        
        # Install zoxide
        if command -v zoxide &> /dev/null; then
            echo -e "${GREEN}✅ zoxide is already installed!${NC}"
        else
            echo -e "${YELLOW}📦 Installing zoxide...${NC}"
            sudo pacman -S --noconfirm zoxide
            if [ $? -eq 0 ]; then
                echo -e "${GREEN}✅ zoxide installed successfully!${NC}"
                echo -e "${CYAN}💡 Add 'eval \"\$(zoxide init zsh)\"' to your .zshrc${NC}"
            else
                echo -e "${RED}❌ Failed to install zoxide${NC}"
            fi
        fi
    else
        echo -e "${YELLOW}⚠️  No supported package manager found. Please install lazygit and ripgrep manually.${NC}"
    fi
else
    echo -e "${YELLOW}⚠️  Tool installation not supported on this OS. Please install lazygit, ripgrep, eza, fzf, and zoxide manually.${NC}"
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

echo ""
echo -e "${RED}🔥 ${YELLOW}IMPORTANT FINAL STEPS ${RED}🔥${NC}"
echo -e "${CYAN}1. ${WHITE}Change your terminal font to 'FiraCode Nerd Font' in terminal preferences${NC}"
echo -e "${CYAN}2. ${WHITE}Restart your terminal or run 'exec zsh' to start using zsh${NC}"
echo -e "${CYAN}3. ${WHITE}Add plugins to your .zshrc: plugins=(git zsh-autosuggestions zsh-syntax-highlighting)${NC}"
echo ""
echo -e "${GREEN}🌟 ${PURPLE}Your terminal is now absolutely legendary! ${GREEN}🌟${NC}"
echo ""