# 1️⃣ Créer les OUs
New-ADOrganizationalUnit -Name "ECOLE" -Path "DC=mediaschool,DC=local"
New-ADOrganizationalUnit -Name "Profs" -Path "OU=ECOLE,DC=mediaschool,DC=local"
New-ADOrganizationalUnit -Name "Administration" -Path "OU=ECOLE,DC=mediaschool,DC=local"
New-ADOrganizationalUnit -Name "Eleves" -Path "OU=ECOLE,DC=mediaschool,DC=local"

# Créer les groupes dans l'OU ECOLE
New-ADGroup -Name "MS-Administration" -GroupScope Global -GroupCategory Security -Path "OU=ECOLE,DC=mediaschool,DC=local"
New-ADGroup -Name "MS-Profs" -GroupScope Global -GroupCategory Security -Path "OU=ECOLE,DC=mediaschool,DC=local"
New-ADGroup -Name "MS-Eleves" -GroupScope Global -GroupCategory Security -Path "OU=ECOLE,DC=mediaschool,DC=local"

# Définir les utilisateurs à créer
$users = @(
    @{SamAccountName="admin1"; Name="Administrateur 1"; OU="Administration"; Group="MS-Administration"; Password="P@ssw0rd1"},
    @{SamAccountName="admin2"; Name="Administrateur 2"; OU="Administration"; Group="MS-Administration"; Password="P@ssw0rd2"},
    @{SamAccountName="prof1"; Name="Professeur 1"; OU="Profs"; Group="MS-Profs"; Password="P@ssw0rd3"},
    @{SamAccountName="prof2"; Name="Professeur 2"; OU="Profs"; Group="MS-Profs"; Password="P@ssw0rd4"},
    @{SamAccountName="eleve1"; Name="Elève 1"; OU="Eleves"; Group="MS-Eleves"; Password="P@ssw0rd5"},
    @{SamAccountName="eleve2"; Name="Elève 2"; OU="Eleves"; Group="MS-Eleves"; Password="P@ssw0rd6"}
)

# Boucle pour créer les utilisateurs et les ajouter aux groupes
foreach ($u in $users) {
    $securePass = ConvertTo-SecureString $u.Password -AsPlainText -Force
    New-ADUser `
        -SamAccountName $u.SamAccountName `
        -Name $u.Name `
        -AccountPassword $securePass `
        -Enabled $true `
        -PasswordNeverExpires $true `
        -Path "OU=$($u.OU),OU=ECOLE,DC=mediaschool,DC=local"

    # Ajouter l'utilisateur au groupe correspondant
    Add-ADGroupMember -Identity $u.Group -Members $u.SamAccountName
}