# Installing on Windows

Spent some time trying to automate this, but symlinks requiring admin privileges
complicated the problem.

Use `cmd`'s `mklink` to install. Symlinks on Windows require admin privileges,
and if Developer Mode is enabled in the Windows settings, `mklink` can be used
without admin. PowerShell also has the `New-Item` command, but I had a lot of
issues with it regarding privileges.

When specifying the source path, make sure to use the full path, rather than
a relative path.

## Finding paths

PowerShell profile: `$PROFILE`
nvim install path: `:echo stdpath('config')` from nvim

## Commands

On systems without admin access, may need to use `mklink /H` to hardlink (does
not require admin access). For directories, use, `mklink /J`.

### Symlink a file

`mklink <DEST> <SOURCE>`

### Symlink a directory

`mklink \D <DEST> <SOURCE>`

### From PowerShell

`cmd /c mklink`
