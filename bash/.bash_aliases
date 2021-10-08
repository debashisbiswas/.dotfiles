alias refresh='source ~/.bashrc'

type git &> /dev/null && alias glo='git log --oneline'

type nvim &> /dev/null && alias vim='nvim'
alias v='vim'

# WSL2 settings
if grep -q "microsoft" /proc/version &>/dev/null; then
    alias powershell='powershell.exe'
    alias cmd='cmd.exe'
fi

