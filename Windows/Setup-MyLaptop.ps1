################################
# Enable SMB1 for Mounting NAS #
################################
# Check if already enabled
#Get-WindowsOptionalFeature -Online -FeatureName "SMB1Protocol"
# Enable SMB1
Enable-WindowsOptionalFeature -Online -FeatureName "SMB1Protocol" -All -NoRestart
# Disable sMB1
#Disable-WindowsOptionalFeature -Online -FeatureName "SMB1Protocol"

#########################
# Enable Linux Subsytem #
#########################
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux -NoRestart

############################
# Setup PowerShell Gallery #
############################
Write-Host "Setup PowerShellGet"
Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force
Install-Module -Name PowerShellGet -Force
Set-PSRepository -InstallationPolicy Trusted -Name PSGallery

###################
# Install modules #
###################
Install-Module -Name AzureRM -Scope AllUsers
Install-Module -Name Az -Scope AllUsers
Install-Module -Name posh-git -Scope AllUsers -Force
Install-Module -Name Pester -Scope AllUsers -AllowClobber

#################################
#  Add PoSH Git to all profiles #
#################################
Import-Module PoSH-Git
Add-PoshGitToProfile -AllHosts

###################
# Install Choco  #
###################
Set-ExecutionPolicy Bypass -Scope Process -Force; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

###########################
# Install Choco Software  #
###########################
choco feature enable -n allowGlobalConfirmation
choco install .\choco.config

###############################
# Rename Computer and restart #
###############################
Rename-Computer -NewName "LEELA-VM"
Restart-Computer -Verbose
