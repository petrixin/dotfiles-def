function finstall
    set -l packages (apt-cache search . | \
        fzf -m \
        --layout=reverse \
        --prompt="Install> " \
        --preview 'apt-cache show {1} | batcat -l yaml --color=always --style=plain' \
        --preview-window=down:70%:wrap --preview-label=" Description "\
        | awk '{print $1}')

    if test -n "$packages"
       sudo apt install $packages
       # commandline -r "sudo apt install $packages"
    end
end
