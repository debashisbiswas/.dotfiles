function iku --description 'fzf over dev directory'
    if type -q fzf
        set -l selection (find ~/dev -mindepth 1 -maxdepth 1 -type d | fzf --height 40%)
        if test -n "$selection"
            cd "$selection"
        end
    else
        echo 'Install fzf to use this command.'
    end
end
