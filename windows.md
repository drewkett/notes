# WSL

## Case Sensitivity

On folders created through wsl, case sensitivity is turned on for that folder by
default. It can be changed using the fsutil.exe. And having that as the default
can be changed using a mount setting in wsl

[Per-directory case sensitivity and WSL](https://blogs.msdn.microsoft.com/commandline/2018/02/28/per-directory-case-sensitivity-and-wsl/)

[Automatically Configuring WSL](https://blogs.msdn.microsoft.com/commandline/2018/02/07/automatically-configuring-wsl/)

## Multiple Installs

[DDoSolitary/LxRunOffline](https://github.com/DDoSolitary/LxRunOffline)

## Accessing files. (Update 1903)

It now starts some builtin file server, where you can launch explorer from wsl
and it accesses the file system using windows explorer. Shows up as a share
drive

## Terminal Colors

mintty wsltty fix colors

Add this to bashr

    LS_COLORS='ow=01;36;40'

Change minttyrc in `%LOCALAPPDATA%\wsltty\home\%USERNAME%\.minttyrc` or
`C:\Users\%USERNAME%\AppData\Roaming\wsltty\config`

to

[https://github.com/oumu/mintty-color-schemes/blob/master/base16-monokai-mod.minttyrc](https://github.com/oumu/mintty-color-schemes/blob/master/base16-monokai-mod.minttyrc)

    ForegroundColour=248,248,242
    BackgroundColour=39,40,34
    CursorColour=253,157,79
    Black=39,40,34
    BoldBlack=117,113,94
    Red=249,38,114
    BoldRed=204,6,78
    Green=166,226,46
    BoldGreen=122,172,24
    Yellow=244,191,117
    BoldYellow=240,169,69
    Blue=102,217,239
    BoldBlue=33,199,233
    Magenta=174,129,255
    BoldMagenta=126,51,255
    Cyan=161,239,228
    BoldCyan=95,227,210
    White=248,248,242
    BoldWhite=249,248,245

# SSH

C:\ProgramData\ssh\administrators_authorized_keys

This is the authorized keys file for all administrative accounts. Permissions
need to be set to remove Authorized Users from view it

Not sure how to use password auth

[PowerShell/Win32-OpenSSH](https://github.com/PowerShell/Win32-OpenSSH/wiki/Install-Win32-OpenSSH)

Need a local account for login to work. AzureAD accounts can't be used to login
as best I can tell

Also need to add a rule for firewall

```
netsh advfirewall firewall add rule name="SSH" protocol=TCP dir=in localport=22 action=allow
```

# Sysinternals

## sdelete

sdelete can securely delete files or directories

sdelete can also write zeros to the empty space on a disk. Useful for fixed size
virtual machines, since it would make compression better for archiving
