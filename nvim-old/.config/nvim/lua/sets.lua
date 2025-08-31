-- NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' m'

vim.wo.number = true
vim.wo.relativenumber = true
vim.o.mouse = 'a'

vim.o.breakindent = true

vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true

vim.o.scrolloff = 5
vim.o.cursorline = true

vim.o.undofile = true

vim.o.ignorecase = true
vim.o.smartcase = true

vim.wo.signcolumn = 'yes'

vim.o.completeopt = 'menuone,noselect'

vim.diagnostic.config {
  float = { source = true },
  jump = { float = true },
}

-- this fixes some treesitter errors on windows
if vim.fn.exists 'shellslash' ~= 0 then vim.o.shellslash = true end

if vim.fn.has 'win32' == 1 then
  -- :h shell-powershell
  vim.cmd [[
    let &shell = executable('pwsh') ? 'pwsh' : 'powershell'
    let &shellcmdflag = '-NoLogo -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new();$PSDefaultParameterValues[''Out-File:Encoding'']=''utf8'';'
    let &shellredir = '2>&1 | %%{ "$_" } | Out-File %s; exit $LastExitCode'
    let &shellpipe  = '2>&1 | %%{ "$_" } | Tee-Object %s; exit $LastExitCode'
    set shellquote= shellxquote=
  ]]
end
