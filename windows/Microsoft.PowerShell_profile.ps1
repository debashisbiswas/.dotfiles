$env:Path += ";C:\bin"

if (Test-Path alias:\cd) {
    Remove-Item alias:\cd
}

function cd {
    param([parameter(Mandatory=$false)] $path)

    if ($path) {
        Set-Location $path
    } else {
        Set-Location $home
    }
}

# For these features, ensure PowerShell 7+
Set-PSReadLineOption -EditMode Emacs
Set-PSReadLineOption -BellStyle None
Set-PSReadLineOption -PredictionSource History
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete

Import-Module ZLocation
Import-Module PSFzf
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+f' -PSReadlineChordReverseHistory 'Ctrl+r'

Set-Alias v nvim
Set-Alias e explorer.exe

function .. {
    Set-Location ..
}

function fcd {
    param ([string]$query = ".")
    $selection = fd -t d $query | fzf
    if ($selection) {
        Set-Location $selection
    }
}

function exists($cmdname)
{
    return [bool](Get-Command -Name $cmdname -ErrorAction SilentlyContinue)
}

function gd {
    git diff
}

function glo {
    git log --oneline
}

function glg {
    git log --all --decorate --oneline --graph
}

function gs {
    git status
}

function gad {
    git add .
}

function gc {
    git commit
}

function which($command) {
    Get-Command $command | Select -ExpandProperty Source
}

if (exists starship) {
    Invoke-Expression (&starship init powershell)
} else {
    Write-Host "Could not find starship in path."
}

if (exists fnm) {
    fnm env --use-on-cd | Out-String | Invoke-Expression
}
