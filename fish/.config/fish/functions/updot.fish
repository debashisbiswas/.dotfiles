function updot
    pushd $DOTFILES
    git pull --autostash --rebase
    popd
end
