if status is-interactive
    # Commands to run in interactive sessions can go here
    starship init fish | source
    zoxide init fish | source
    
    # Nastaveni klavesovych zkratek pro fzf.fish
    fzf_configure_bindings --directory=\cf

### Aliasy
    alias ls='eza --group-directories-first'
    alias ll='ls --header --long'
    alias la='ll --all'
    alias lt='ll --tree --level=2 --git'
    alias lta='la --tree --level=2 --git'
    
    alias fd='find (fzf)'

    alias mv='mv -i'
    # alias cp='cp -i'
    # alias rm='rm -i'

    alias mkdir='mkdir -pv'
  
    alias home='z ~'
    alias cd='z' 
    alias ..='z ..'
    alias ...='z ../..'
    alias ....='z ../../..'

### Zkratky
    abbr --add refish "source ~/.config/fish/config.fish"    

    abbr --add up "sudo apt update"
    abbr --add ins "sudo apt install"
    abbr --add rem "sudo apt autoremove"

    abbr --add ss "ss -tulpn"
    abbr --add decompress "tar -xzf"
    abbr --add dus "du -h --max-depth=1 | sort -hr"
    abbr --add gcm "git commit -m"
    # abbr --add wget "wget -cb -O "

    # bind \ec 'clear; commandline -f repaint'

end
