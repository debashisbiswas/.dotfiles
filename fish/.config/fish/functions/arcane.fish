function arcane
    set -l selected (find "$HOME/dev" -mindepth 1 -maxdepth 1 -type d | fzf)

    if test -n "$selected"
        set -l session_name (string replace -a . _ (path basename $selected))

        if not tmux has-session -t=$session_name 2>/dev/null
            tmux new-session -d -s $session_name -c $selected -n "editor" "nvim +Oil"
            tmux new-window -t $session_name -c $selected -n "terminal"
        end
        
        if set -q TMUX
            tmux switch-client -t $session_name
        else
            tmux attach-session -t $session_name
        end
    end
end
