#!/bin/bash

# --- KONFIGURACE ---
REPO_URL="https://github.com/petrixin/dotfiles-def.git"
CONFIG_DIR="$HOME/.config"

echo "Instalace prostředí..."

# (V základním Debianu obvykle chybí)
#if ! command -v eza &> /dev/null; then
#    echo "Přidání repozitáře pro EZA..."
#    sudo mkdir -p /etc/apt/keyrings
#    wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
#    echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
#    sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
#fi

# HROMADNÁ INSTALACE BALÍČKŮ (APT)
echo "Aktualizace systému a instalace všech programů..."
sudo apt update
sudo apt install -y fish git curl fzf fd-find zoxide eza bat

# OPRAVA FD-FIND
mkdir -p ~/.local/bin
ln -sf $(which fdfind) ~/.local/bin/fd

# STAŽENÍ A ROZMÍSTĚNÍ SOUBORŮ
echo "Stažení konfigurací z GitHubu..."
rm -rf "$HOME/dotfiles_temp"
git clone "$REPO_URL" "$HOME/dotfiles_temp"

echo "Kopírování config souborů..."
mkdir -p "$CONFIG_DIR/fish"

cp -r "$HOME/dotfiles_temp/fish/." "$CONFIG_DIR/fish/"

# Úklid
rm -rf "$HOME/dotfiles_temp"





# Instalace samotného Fishera
fish -c 'curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher'

# Instalace pluginu FZF.fish
fish -c 'fisher install patrickf1/fzf.fish'

# Aktualizace pluginů
fish -c 'fisher update'



# NASTAVENÍ SHELLU A PLUGINŮ
echo "Instalace Fisher a pluginů..."

# Vyčištění
rm -f "$CONFIG_DIR/fish/fish_plugins"

# Spuštění Fish instalace Fishera a fzf_fish
fish << 'EOF'
    # Instalace Fishera
    curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source
    
    # Instalace pluginů
    fisher install jorgebucaran/fisher
    fisher install patrickf1/fzf.fish
    
    fisher update
EOF