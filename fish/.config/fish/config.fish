set -gx DOTFILES "$HOME/.dotfiles"
set -gx EDITOR nvim
set -gx FLYCTL_INSTALL "$HOME/.fly"
set -gx PYENV_ROOT $HOME/.pyenv
set -gx VOLTA_HOME "$HOME/.volta"

fish_add_path -g "$HOME/.cargo/bin"
fish_add_path -g "$HOME/.local/bin"
fish_add_path -g "$HOME/.local/share"
fish_add_path -g "$HOME/go/bin"
fish_add_path -g "/usr/local/go/bin"
fish_add_path -g "$FLYCTL_INSTALL/bin"
fish_add_path -g "$PYENV_ROOT/shims"
fish_add_path -g "$PYENV_ROOT/bin"
fish_add_path -g "$VOLTA_HOME/bin"
fish_add_path -g "$HOME/.sst/bin"

if status is-interactive
    abbr dot "cd $DOTFILES"

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

    bind \cf arcane
end

if type -q pyenv
    pyenv init - | source
end

if type -q nixos-rebuild
    abbr rebuild "sudo nixos-rebuild --flake \"$DOTFILES/nixos#$(hostname)\" switch"
end

if type -q docker
    abbr dc "docker compose"
end

if type -q direnv
    direnv hook fish | source
end

alias wl "xdg-open 'https://www.youtube.com/playlist?list=WL'"

abbr refresh "source ~/.config/fish/config.fish"
