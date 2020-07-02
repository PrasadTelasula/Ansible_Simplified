<powershell>
Enable-PSRemoting -force 
Set-Service WinRM -StartMode Automatic
Set-Item -Force WSMan:\localhost\Service\Auth\Basic $True
winrm set winrm/config/service/auth '@{Basic="true"}'
winrm set winrm/config/service '@{AllowUnencrypted="true"}'
New-NetFirewallRule -DisplayName AllowWinRM -Direction Outbound -LocalPort 5985 -Protocol TCP -Action Allow
New-NetFirewallRule -DisplayName AllowWinRM -Direction Inbound -LocalPort 5985 -Protocol TCP -Action Allow
Stop-Service -Name "WinRM"
Start-Service -Name "WinRM"
</powershell>
