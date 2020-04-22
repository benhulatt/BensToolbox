#set servers to point to Let's Encrypt
Set-PAServer LE_PROD

#Generate the certificate (-install will install in windows for us)
#New-PACertificate vcc.avecsys.net -AcceptTOS -Contact messages@avecsys.com -Install -Force

#incase it's already generated run a renewal
Submit-Renewal -AllOrders

#get-pacertificate gives us the cert details, Thumbprint is used to match with the one on Veeam when we import it there.
$pacert = Get-PACertificate
$pathumb = $pacert.Thumbprint


# Import the cert in Veeam

#add veeam to PowerShell
asnp VeeamPSSnapin

#Connect to the locally running veeam instance
Connect-VBRServer -Server localhost

#Select the certificate we want to use (matching the thumbprint to get the latest correct one)
$certificate = Get-VBRCloudGatewayCertificate -FromStore | Where {$_.Thumbprint -eq $pathumb}

#Import the cert in veeam
Add-VBRCloudGatewayCertificate -Certificate $certificate

#Disconnect from veeam
Disconnect-VBRServer

#Leave the script
Return
