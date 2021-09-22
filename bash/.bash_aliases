alias refresh='source ~/.bashrc'

[ -x /usr/bin/nvim ] && alias vim='nvim'
alias v='vim'

# WSL2 settings
if grep -q "microsoft" /proc/version &>/dev/null; then
    alias powershell='powershell.exe'
    alias cmd='cmd.exe'
fi

