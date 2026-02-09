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