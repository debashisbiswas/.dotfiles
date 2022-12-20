alias refresh='source ~/.bashrc'

if command -v fzf >/dev/null 2>&1; then
    function iku () {
        selection=$(find ~/dev -mindepth 1 -maxdepth 1 -type d | fzf --height 40%)
        if [[ -n "$selection" ]]; then
            cd "$selection"
        fi
    }
    export -f iku
fi

if command -v git >/dev/null 2>&1; then
    alias glo='git log --oneline'
    alias gs='git status'
    alias gad='git add .'
    alias gc='git commit'
fi

if command -v nvim >/dev/null 2>&1; then
    alias vim='nvim'
fi
alias v='vim'

# WSL2 settings
if grep -q "microsoft" /proc/version &>/dev/null; then
    alias powershell='powershell.exe'
    alias cmd='cmd.exe'
fi

