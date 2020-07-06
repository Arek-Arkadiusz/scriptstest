# Enable port 5986 on Azure VM (Run Powershell As admin):
New-NetFirewallRule -Displayname "WinRm-HTTPS Allow PS Remoting" -direction inbound -LocalPort 5986 -Protocol tcp -Action allow

$selector_set = @{
    Address = '*'
    Transport = "HTTPS"
}

$value_set = @{
    Hostname = (get-childitem -path Certificate::LocalMachine\My | Where-Object { $_.Subject -like "*$($env:computername)*" }).DnsNameList.Unicode
    CertificateThumbprint = (get-childitem -path Certificate::LocalMachine\My | Where-Object { $_.Subject -like "*$($env:computername)*" }).Thumbprint
}

# winrm create winrm/config/Listener?Address=*+Transport=HTTPS @{Hostname="";CertificateThumbprint=""}
# https://docs.microsoft.com/en-us/powershell/module/microsoft.wsman.management/new-wsmaninstance?view=powershell-5.1
New-WSManInstance -ResourceURI "winrm/config/Listener" -SelectorSet $selector_set -ValueSet $value_set

# Validate listener
# WinRM e winrm/config/listener
