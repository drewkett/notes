# WSL
## Case Sensitivity

On folders created through wsl, case sensitivity is turned on for that folder by default. It can be changed using the fsutil.exe. And having that as the default can be changed using a mount setting in wsl

[Per-directory case sensitivity and WSL](https://blogs.msdn.microsoft.com/commandline/2018/02/28/per-directory-case-sensitivity-and-wsl/)

[Automatically Configuring WSL](https://blogs.msdn.microsoft.com/commandline/2018/02/07/automatically-configuring-wsl/)

## Multiple Installs

[DDoSolitary/LxRunOffline](https://github.com/DDoSolitary/LxRunOffline)

## Accessing files. (Update 1903)

It now starts some builtin file server, where you can launch explorer from wsl and it accesses the file system using windows explorer. Shows up as a share drive

# SSH
C:\ProgramData\ssh\administrators_authorized_keys

This is the authorized keys file for all administrative accounts. Permissions need to be set to remove Authorized Users from view it

Not sure how to use password auth

[PowerShell/Win32-OpenSSH](https://github.com/PowerShell/Win32-OpenSSH/wiki/Install-Win32-OpenSSH)

Need a local account for login to work. AzureAD accounts can't be used to login as best I can tell