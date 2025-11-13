1️⃣ Installer et autoriser le rôle DHCP
# Installer le rôle DHCP
Install-WindowsFeature -Name DHCP -IncludeManagementTools

# Autoriser le serveur DHCP dans AD
Add-DhcpServerInDC -DnsName "SRV-DC1.mediaschool.local" -IPAddress 192.168.100.10


2️⃣ Créer un scope
Add-DhcpServerv4Scope -Name "SCOPE-SALLE-INFO" -StartRange 192.168.100.50 -EndRange 192.168.100.200 -SubnetMask 255.255.255.0 -LeaseDuration 06:00:00

# Ajouter des exclusions si nécessaire (ex : 192.168.100.10-192.168.100.20 pour serveurs)
Add-DhcpServerv4ExclusionRange -ScopeId 192.168.100.0 -StartRange 192.168.100.10 -EndRange 192.168.100.20


3️⃣ Configurer les options du scope
# 003 Router (passerelle par défaut)
Set-DhcpServerv4OptionValue -ScopeId 192.168.100.0 -Router 192.168.100.1

# 006 DNS Servers
Set-DhcpServerv4OptionValue -ScopeId 192.168.100.0 -DnsServer 192.168.100.10

# 015 DNS Domain Name
Set-DhcpServerv4OptionValue -ScopeId 192.168.100.0 -DnsDomain "mediaschool.local"


4️⃣ Activer mises à jour dynamiques DNS sécurisées par DHCP
Set-DhcpServerv4DnsSetting -DynamicUpdates "Always"



