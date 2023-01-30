set -U fish_greeting

set -gx EDITOR nvim
set PATH $PATH ~/.cargo/bin

if status is-interactive
    # Commands to run in interactive sessions can go here

    if type -q git
        abbr gd 'git diff'
        abbr glo 'git log --oneline'
        abbr glg 'git log --all --decorate --oneline --graph'
        abbr gs 'git status'
        abbr gad 'git add .'
        abbr gc 'git commit'
    end

    if type -q nvim
        alias v nvim
    end
end
