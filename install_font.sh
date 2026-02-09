# Instalace FONTU (JetBrainsMono Nerd Font)
echo "Instalace JetBrainsMono Nerd Font..."

# Vytvoření složky pro fonty
mkdir -p ~/.local/share/fonts

# Stažení fontu
cd /tmp
wget -O JetBrainsMono.zip https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/JetBrainsMono.zip

# Instalace unzip, pokud není
if ! command -v unzip &> /dev/null; then
    sudo apt install -y unzip
fi

# Rozbalení souborů do složky fonts
unzip -o JetBrainsMono.zip -d ~/.local/share/fonts

# Aktualizace cache fontů
fc-cache -fv

# Úklid
rm JetBrainsMono.zip

echo "Font nainstalován."

# Instalace STARSHIP
echo "Instaluji Starship..."
curl -sS https://starship.rs/install.sh | sh -s -- -y

curl -L https://raw.githubusercontent.com/petrixin/dotfiles-def/main/starship.toml -o ~/.config/starship.toml