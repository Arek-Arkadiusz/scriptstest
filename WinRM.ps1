# Enable port 5986 on Azure VM (Run Powershell As admin):
New-NetFirewallRule -Displayname "WinRm-HTTPS Allow PS Remoting" -direction inbound -LocalPort 5986 -Protocol tcp -Action allow
