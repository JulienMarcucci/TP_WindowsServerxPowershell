🖥️ 1️⃣ SRV-DC1 — Contrôleur de domaine
⚙️ Configuration IP statique
New-NetIPAddress -InterfaceAlias "Ethernet" -IPAddress 192.168.100.10 -PrefixLength 24 -DefaultGateway 192.168.100.1
Set-DnsClientServerAddress -InterfaceAlias "Ethernet" -ServerAddresses 127.0.0.1

🏷️ Renommer le serveur
Rename-Computer -NewName "SRV-DC1" -Restart

🖥️ 2️⃣ SRV-FS1 — Serveur de fichiers
⚙️ Configuration IP statique
New-NetIPAddress -InterfaceAlias "Ethernet" -IPAddress 192.168.100.20 -PrefixLength 24 -DefaultGateway 192.168.100.1
Set-DnsClientServerAddress -InterfaceAlias "Ethernet" -ServerAddresses 192.168.100.10

2️⃣ Promouvoir le serveur en contrôleur de domaine

Pour créer un nouveau domaine mediaschool.local :
Install-ADDSForest `
 -DomainName "mediaschool.local" `
 -CreateDNSDelegation:$false `
 -DatabasePath "C:\Windows\NTDS" `
 -DomainMode "Default" `
 -ForestMode "Default" `
 -InstallDNS:$true `
 -LogPath "C:\Windows\NTDS" `
 -SysvolPath "C:\Windows\SYSVOL" `
 -Force:$true


🏷️ Rejoindre le domaine
Add-Computer -DomainName "mediaschool.local" -Credential mediaschool\Administrateur -Restart

🧪 4️⃣ Tests de connectivité (à faire sur chaque machine)
ping 192.168.100.10     # Ping SRV-DC1
ping 192.168.100.20     # Ping SRV-FS1
ping mediaschool.local  # Vérifie la résolution DNS
