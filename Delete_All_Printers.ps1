Function Delete-Printers
{
	$NetworkPrinters = Get-WmiObject -Class Win32_Printer
	If ($NetworkPrinters -ne $null)
	{
		Try
		{
			Foreach($NetworkPrinter in $NetworkPrinters)
			{
				$NetworkPrinter.Delete()
				Write-Host "Successfully deleted the network printer:" + $NetworkPrinter.Name -ForegroundColor Green	
			}
		}
		Catch
		{
			Write-Host $_
		}
	}
	Else
	{
		Write-Warning "Cannot find network printer"
	}
}

Delete-Printers
