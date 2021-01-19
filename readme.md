<p align="center">
  <a href="https://www.powershellgallery.com/packages/PowerShellManager"><img src="https://img.shields.io/powershellgallery/v/PowerShellManager.svg"></a>
  <a href="https://www.powershellgallery.com/packages/PowerShellManager"><img src="https://img.shields.io/powershellgallery/vpre/PowerShellManager.svg?label=powershell%20gallery%20preview&colorB=yellow"></a>
  <a href="https://github.com/EvotecIT/PowerShellManager"><img src="https://img.shields.io/github/license/EvotecIT/PowerShellManager.svg"></a>
</p>

<p align="center">
  <a href="https://www.powershellgallery.com/packages/PowerShellManager"><img src="https://img.shields.io/powershellgallery/p/PowerShellManager.svg"></a>
  <a href="https://github.com/EvotecIT/PowerShellManager"><img src="https://img.shields.io/github/languages/top/evotecit/PowerShellManager.svg"></a>
  <a href="https://github.com/EvotecIT/PowerShellManager"><img src="https://img.shields.io/github/languages/code-size/evotecit/PowerShellManager.svg"></a>
  <a href="https://www.powershellgallery.com/packages/PowerShellManager"><img src="https://img.shields.io/powershellgallery/dt/PowerShellManager.svg"></a>
</p>

<p align="center">
  <a href="https://twitter.com/PrzemyslawKlys"><img src="https://img.shields.io/twitter/follow/PrzemyslawKlys.svg?label=Twitter%20%40PrzemyslawKlys&style=social"></a>
  <a href="https://evotec.xyz/hub"><img src="https://img.shields.io/badge/Blog-evotec.xyz-2A6496.svg"></a>
  <a href="https://www.linkedin.com/in/pklys"><img src="https://img.shields.io/badge/LinkedIn-pklys-0077B5.svg?logo=LinkedIn"></a>
</p>

# PowerShellManager

Little PowerShell module to extract PowerShell scripts that no longer exists on disk but were run and are still in Event Logs.

# Usage

Extracing PowerShell scripts from Windows PowerShell Event Log and saving it to ScriptsLocal directory in same folder.
Format makes sure the script is formatted and, and AddMarkdown adds additional information to asses where the script is coming from.

```powershell
Restore-PowerShellScript -Type WindowsPowerShell -Path $PSScriptRoot\ScriptsLocal -Verbose -Format -AddMarkdown
```

Same as above but with a difference that it scans remote servers (two of them). It does it in parallel.

```powershell
# Keep in mind AD1/AD2 will do it in parallel
Restore-PowerShellScript -Type WindowsPowerShell -Path $PSScriptRoot\ScriptsRemote -ComputerName AD1, AD2 -Verbose -Format -AddMarkdown
```

## To install

Just install module from PowerShellGallery.

```powershell
Install-Module -Name PowerShellManager -AllowClobber -Force
```

Force and AllowClobber aren't necessary, but they do skip errors in case some appear.

## And to update

```powershell
Update-Module -Name PowerShellManager
```

That's it. Whenever there's a new version, you run the command, and you can enjoy it. Remember that you may need to close, reopen PowerShell session if you have already used module before updating it.

**The essential thing** is if something works for you on production, keep using it till you test the new version on a test computer. I do changes that may not be big, but big enough that auto-update may break your code. For example, small rename to a parameter and your code stops working! Be responsible!

## Changelog

- 0.1.2 - 2021.01.19
  - Fix for reading from file system
- 0.1.1 - 2020.08.28
  - Additional security (prevents from accidental execution)
  - First release
