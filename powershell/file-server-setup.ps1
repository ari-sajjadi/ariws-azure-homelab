# AriWS HomeLab - Department file server setup
# Session 02 - 2026-09-16
# No passwords are stored in this script.

$FolderGroups = @{
    "Management" = "GG_Management"
    "HR"         = "GG_HR"
    "Sales"      = "GG_Sales"
    "Support"    = "GG_Support"
    "IT"         = "GG_IT"
}

$Root = "C:\CompanyData"
New-Item -Path $Root -ItemType Directory -Force | Out-Null

foreach ($Folder in $FolderGroups.Keys) {
    $Path = Join-Path $Root $Folder
    $Group = $FolderGroups[$Folder]

    New-Item -Path $Path -ItemType Directory -Force | Out-Null

    icacls $Path /inheritance:r
    icacls $Path /grant:r `
        "ARIWS\$($Group):(OI)(CI)M" `
        "ARIWS\GG_IT_Admins:(OI)(CI)F" `
        "BUILTIN\Administrators:(OI)(CI)F" `
        "NT AUTHORITY\SYSTEM:(OI)(CI)F"

    if (-not (Get-SmbShare -Name $Folder -ErrorAction SilentlyContinue)) {
        New-SmbShare -Name $Folder -Path $Path `
            -FullAccess "ARIWS\GG_IT_Admins" `
            -ChangeAccess "ARIWS\$Group"
    }
}

Write-Host "\n=== SMB Shares ===" -ForegroundColor Cyan
Get-SmbShare | Where-Object Name -in $FolderGroups.Keys

foreach ($Share in $FolderGroups.Keys) {
    Write-Host "\n===== $Share =====" -ForegroundColor Cyan
    Get-SmbShareAccess -Name $Share |
        Format-Table Name,AccountName,AccessControlType,AccessRight -AutoSize
}
