function _add_to_path
    if test (count $argv) -gt 0
        set -gx PATH $argv $PATH
    else
        echo "warning: _add_to_path called without argument"
    end
end

set -gx EDITOR nvim
set -gx FLYCTL_INSTALL "$HOME/.fly"
set -gx PYENV_ROOT $HOME/.pyenv

_add_to_path \
    "$HOME/.cargo/bin" \
    "$HOME/.local/bin" \
    "/usr/local/go/bin" \
    "$HOME/go/bin" \
    "$FLYCTL_INSTALL/bin" \
    "$PYENV_ROOT/shims" \
    "$PYENV_ROOT/bin"

if status is-interactive
    alias dot "cd ~/.dotfiles"

    if type -q git
        abbr gd "git diff"
        abbr glo "git log --oneline"
        abbr glg "git log --all --decorate --oneline --graph"
        abbr gs "git status"
        abbr gad "git add ."
        abbr gc "git commit"
    end

    if type -q nvim
        alias v nvim
    end

    function ls -d 'exa instead of ls'
        if type -q exa
            exa --group-directories-first --git $argv
        else
            command ls --color=auto $argv
        end
    end
end

if type -q fnm
    fnm env --use-on-cd | source
end

if type -q starship
    starship init fish | source
end

if type -q pyenv
    pyenv init - | source
end
