function _add_to_path
    if test (count $argv) -gt 0
        set -gx PATH $argv $PATH
    else
        echo "warning: _add_to_path called without argument"
    end
end

set -gx EDITOR nvim
set -gx VOLTA_HOME "$HOME/.volta"

_add_to_path "$VOLTA_HOME/bin" "$HOME/.cargo/bin" "$HOME/.local/bin"

if status is-interactive
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

    alias ls "ls -p"
    alias la "ls -A"
    alias ll "ls -l"
    alias lla "ll -A"

    if type -q exa
      alias ls "exa -F"
      alias la "ls -a"
      alias ll "ls -l"
      alias lla "ll -a"
    end
end
