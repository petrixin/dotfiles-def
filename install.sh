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
sudo apt install -y fish git curl fzf fd-find zoxide eza

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

# NASTAVENÍ SHELLU A PLUGINŮ

fish -c "curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher"
fish -c "fisher install patrickf1/fzf.fish"
# Nastavení Fishe jako výchozího shellu (pokud ještě není)
if [ "$SHELL" != "$(which fish)" ]; then
    echo "Změna shell na Fish..."
    sudo chsh -s $(which fish) $USER
fi

echo "Instalace Fisher a pluginů..."

# Vyčištění
rm -f ~/.config/fish/fish_plugins

# Instalace samotného Fishera
fish -c 'curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher'

# Instalace pluginu FZF.fish
echo "Instaluje se fzf.fish..."
fish -c 'fisher install patrickf1/fzf.fish'

# Aktualizace pluginů (pro jistotu)
fish -c 'fisher update'

echo "Vše dokončeno."
echo "Restartuj terminál."