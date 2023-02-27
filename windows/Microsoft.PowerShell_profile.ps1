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

Set-PSReadLineOption -EditMode Emacs
Set-PSReadLineOption -BellStyle None
Set-PSReadLineOption -PredictionSource History

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

Invoke-Expression (&starship init powershell)
