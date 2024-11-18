$env:Path += ";C:\bin"
$env:Path += ";${HOME}\go\bin"

$env:DOTFILES = "$HOME\.dotfiles"
$env:STARSHIP_CONFIG = "$env:DOTFILES\starship\.config\starship.toml"

if (Test-Path alias:\cd)
{
    Remove-Item alias:\cd -Force
}

function cd
{
    param([parameter(Mandatory=$false)] $path)

    if ($path)
    {
        Set-Location $path
    } else
    {
        Set-Location $home
    }
}

# For these features, ensure PowerShell 7+
Set-PSReadLineOption -EditMode Emacs
Set-PSReadLineOption -BellStyle None
try
{
    Set-PSReadLineOption -PredictionSource History
} catch
{
    # Just continue without enabling the feature.
}
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete

# First, Install-Module PSFzf
Import-Module PSFzf
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+f' -PSReadlineChordReverseHistory 'Ctrl+r'

Set-Alias v nvim
Set-Alias e explorer.exe

$env:Editor = "nvim"

function ..
{
    Set-Location ..
}

function fcd
{
    param ()
    $selection = Get-ChildItem $query -Directory | Select-Object -ExpandProperty FullName | fzf
    if ($selection)
    {
        Set-Location $selection
    }
}

function f
{
    $selection = Get-ChildItem "~/dev" -Directory | Select-Object -ExpandProperty FullName | fzf
    if ($selection)
    {
        Set-Location $selection
    }
}

function exists($cmdname)
{
    return [bool](Get-Command -Name $cmdname -ErrorAction SilentlyContinue)
}

function gd
{
    git diff
}

function glo
{
    git log --oneline
}

function glg
{
    git log --all --decorate --oneline --graph
}

function gs
{
    git status
}

function gad
{
    git add .
}

if (Test-Path alias:\gc)
{
    Remove-Item alias:\gc -Force
}

function gc
{
    git commit
}

function dot
{
    Set-Location $env:DOTFILES
}

function which($command)
{
    Get-Command $command | Select-Object -ExpandProperty Source
}

if (exists starship)
{
    Invoke-Expression (&starship init powershell)
}

if (exists fnm)
{
    fnm env --use-on-cd | Out-String | Invoke-Expression
}

if (exists eza)
{
    Set-Alias -Name ls -Value eza
}

# Remove blue background from directory listings
$PSStyle.FileInfo.Directory = "`e[34m"

$ProfileDir = Split-Path -Parent $PROFILE
$LocalPS1 = Join-Path $ProfileDir "local.ps1"

if (Test-Path $LocalPS1)
{
    . $LocalPS1
}
