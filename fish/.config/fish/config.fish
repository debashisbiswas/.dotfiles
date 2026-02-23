set -g fish_greeting ""

set -gx DOTFILES "$HOME/.dotfiles"
set -gx EDITOR nvim
set -gx FLYCTL_INSTALL "$HOME/.fly"

if test (hostname) = "AZ75LT2YBB3J3"
    set -gx IS_WORK_MACHINE true
else
    set -gx IS_WORK_MACHINE false
end

fish_add_path -g "$HOME/.cargo/bin"
fish_add_path -g "$HOME/.local/bin"
fish_add_path -g "$HOME/.local/share"
fish_add_path -g "$HOME/bin"
fish_add_path -g "$HOME/go/bin"
fish_add_path -g "/usr/local/go/bin"
fish_add_path -g "$FLYCTL_INSTALL/bin"
fish_add_path -g "$HOME/.sst/bin"
fish_add_path -g "$HOME/.emacs.d/bin"
fish_add_path -g "$HOME/.config/emacs/bin"

if test (uname) = Darwin
    eval (brew shellenv)
end

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

    if type -q starship
        starship init fish | source
    end

    bind \cf arcane
end

if type -q pyenv
    pyenv init - | source
end

if type -q darwin-rebuild
    abbr rebuild "sudo darwin-rebuild --flake \"$DOTFILES/nixos#$(hostname)\" switch"
end

if type -q nixos-rebuild
    abbr rebuild "sudo nixos-rebuild --flake \"$DOTFILES/nixos#$(hostname)\" switch"
end

if string match -q "*microsoft*" (uname -r)
    abbr rebuild "home-manager --flake \"$DOTFILES/nixos#$(hostname)\" switch"
end

if type -q nix
    abbr ns "nix shell nixpkgs#"
    abbr nr "nix run nixpkgs#"
end

if type -q docker
    abbr dc "docker compose"
end

if type -q direnv
    direnv hook fish | source
end

if type -q zoxide
    zoxide init fish | source
end

alias wl "xdg-open 'https://www.youtube.com/playlist?list=WL'"

abbr refresh "source ~/.config/fish/config.fish"
