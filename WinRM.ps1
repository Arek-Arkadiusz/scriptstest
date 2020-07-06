# Enable port 5986 on Azure VM (Run Powershell As admin):
New-NetFirewallRule -Displayname "WinRm-HTTPS Allow PS Remoting" -direction inbound -LocalPort 5986 -Protocol tcp -Action allow

$selector_set = @{
    Address = (get-childitem -path Certificate::CurrentUser\My | Where-Object { $_.Subject -like "*$($env:computername)*" }).DnsNameList.Unicode
    Transport = "HTTPS"
}

$value_set = @{
    CertificateThumbprint = (get-childitem -path Certificate::CurrentUser\My | Where-Object { $_.Subject -like "*$($env:computername)*" }).Thumbprint
}

New-WSManInstance -ResourceURI "winrm/config/Listener" -SelectorSet $selector_set -ValueSet $value_set

