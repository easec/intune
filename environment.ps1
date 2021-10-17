Write-Host "Lägger till modul för Active Directory"
Import-Module ActiveDirectory

Write-Host "Skapar OU-struktur"

New-ADOrganizationalUnit -Name "Lomma" -Path "DC=easec,DC=net"

New-ADOrganizationalUnit -Name "Personal" -Path "OU=Lomma,DC=easec,DC=net"
New-ADOrganizationalUnit -Name "Enheter" -Path "OU=Lomma,DC=easec,DC=net"
New-ADOrganizationalUnit -Name "Klienter" -Path "OU=enheter,OU=Lomma,DC=easec,DC=net"
New-ADOrganizationalUnit -Name "Servrar" -Path "OU=enheter,OU=Lomma,DC=easec,DC=net"
New-ADOrganizationalUnit -Name "Mobila" -Path "OU=enheter,OU=Lomma,DC=easec,DC=net"

Write-Host "Skapar användare Gullan Holm, Karl Hult, Christer Larsson och Majken Larsson"
Write-Host "Skapar användare Gullan Holm"
New-ADUser -Name "Gullan Holm" -GivenName "Gullan" -Surname "Holm" -SamAccountName "gullanh" -UserPrincipalName "gullanh@easec.net" -Path "OU=Personal,OU=Lomma,DC=easec,DC=net" -AccountPassword(Read-Host -AsSecureString "Skriv in lösenord") -Enabled $true
Write-Host "Lagt till Gullan Holm"
Write-Host "Skapar användare Karl Hult"
New-ADUser -Name "Karl Hult" -GivenName "Karl" -Surname "Hult" -SamAccountName "karlh" -UserPrincipalName "karlh@easec.net" -Path "OU=Personal,OU=Lomma,DC=easec,DC=net" -AccountPassword(Read-Host -AsSecureString "Skriv in lösenord") -Enabled $true
Write-Host "Lagt till Karl Hult"

Write-Host "Skapar användare Christer Larsson"
New-ADUser -Name "Christer Larsson" -GivenName "Christer" -Surname "Larsson" -SamAccountName "christerl" -UserPrincipalName "christerl@easec.net" -Path "OU=Personal,OU=Lomma,DC=easec,DC=net" -AccountPassword(Read-Host -AsSecureString "Skriv in lösenord") -Enabled $true
Write-Host "Lagt till Christer Larsson"

Write-Host "Skapar användare Majken Larsson"
New-ADUser -Name "Majken Larsson" -GivenName "Majken" -Surname "Larsson" -SamAccountName "majkenl" -UserPrincipalName "majkenl@easec.net" -Path "OU=Personal,OU=Lomma,DC=easec,DC=net" -AccountPassword(Read-Host -AsSecureString "Skriv in lösenord") -Enabled $true
Write-Host "Lagt till Majken Larsson"




Write-Host "Lägger till användare i gruppen Lommapersonal"
Add-ADGroupMember -Identity "Lommapersonal" -Members gullanh, karlh, christerl, majkenl
Write-Host "Användare tillagda i grupp"

Write-Host "Modifiera till Never Expires"
Get-ADUser -Filter * -SearchBase "OU=Personal,OU=Lomma,DC=easec,DC=net" | Set-ADUser -PasswordNeverExpires:$True
Write-Host "Klart för Lommapersonal"
Get-ADUser Administrator | Set-ADUser -PasswordNeverExpires:$True 
Write-Host "Klart för Administrator"
