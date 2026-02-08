function fremove
    # dpkg -l | sed ... odstraní hlavičku
    # awk '{print $2}' vybere jen sloupec se jmény balíčků
    
    set -l packages (dpkg -l | sed '1,5d' | awk '{print $2}' | \
        fzf -m \
        --layout=reverse \
        --prompt="Remove> " \
        --preview 'apt-cache show {} | batcat -l yaml --color=always --style=plain' \
        --preview-window=down:70%:wrap --preview-label=" Description ")

    if test -n "$packages"
        sudo apt remove $packages
        # commandline -r "sudo apt remove $packages"
    end
end
