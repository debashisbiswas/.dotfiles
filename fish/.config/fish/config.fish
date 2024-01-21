set -gx EDITOR nvim
set -gx FLYCTL_INSTALL "$HOME/.fly"
set -gx PYENV_ROOT $HOME/.pyenv
set -gx VOLTA_HOME "$HOME/.volta"

set -l PATH_ADDITIONS \
    "$HOME/.cargo/bin" \
    "$HOME/.local/bin" \
    "$HOME/.local/share" \
    "$HOME/go/bin" \
    "/usr/local/go/bin" \
    "$FLYCTL_INSTALL/bin" \
    "$PYENV_ROOT/shims" \
    "$PYENV_ROOT/bin" \
    "$VOLTA_HOME/bin"

set -gx PATH $PATH_ADDITIONS $PATH

if status is-interactive
    abbr dot "cd ~/.dotfiles"

    if type -q git
        abbr gd "git diff"
        abbr gdc "git diff --cached"
        abbr glo "git log --oneline"
        abbr glg "git log --all --decorate --oneline --graph"
        abbr gs "git status"
        abbr gad "git add ."
        abbr gc "git commit"
    end

    if type -q nvim
        abbr v nvim
    end

    function ls -d 'eza instead of ls'
        if type -q eza
            eza --group-directories-first --git $argv
        else
            command ls --color=auto $argv
        end
    end

    if type -q starship
        starship init fish | source
    end
end

if type -q pyenv
    pyenv init - | source
end
