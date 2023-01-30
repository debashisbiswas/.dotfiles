set -U fish_greeting

set -gx EDITOR nvim
set PATH $PATH ~/.cargo/bin
set -U nvm_default_version lts

if status is-interactive
    # Commands to run in interactive sessions can go here

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
