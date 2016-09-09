# Copyright (c) 2016, Vira
# All rights reserved.

# ---------------------------------

# Some need variables
$currentDir = $PSScriptRoot
$Arch = (Get-Process -Id $PID).StartInfo.EnvironmentVariables["PROCESSOR_ARCHITECTURE"];
$global:destinationDir = ""
$global:fileName = ""
$global:source = $null # Global, because Powershell wants it to be ¯\_(ツ)_/¯

$source86 = "http://download.oracle.com/otn-pub/java/jdk/8u102-b14/jre-8u102-windows-i586.exe"
$source64 = "http://download.oracle.com/otn-pub/java/jdk/8u102-b14/jre-8u102-windows-x64.exe"

# Setup variables
Function SetupArchitectureSpecifics{
	If($Arch -eq 'x86'){
		Write-Host "You have an x86 system!"
		$global:source = $source86
		$global:destinationDir = "C:\Program Files (x86)\Java\jre1.8.0_102\"
		$global:fileName = "jre-8u102-windows-i586.exe"
		
		return
	}
	
	Write-Host "You have an x64 system!"
	$global:source = $source64
	$global:destinationDir = "C:\Program Files\Java\jre1.8.0_102\"
	$global:fileName = "jre-8u102-windows-x64.exe"
}

# Install Java
Function InstallJava{
	Write-Host source
	Write-Host $$global:destinationDir
	$client = New-Object System.Net.WebClient
	# Single Example
	$client.Headers.Add([System.Net.HttpRequestHeader]::Cookie, "oraclelicense=accept-securebackup-cookie")
	$client.DownloadFile($source, "$($currentDir)\$($global:fileName)")
	
	& "$($currentDir)\$($global:fileName)"
	do{
		Read-Host 'Java isnt installed now, please come back after the installation finished...' | Out-Null
	}
	until(Test-Path -Path $global:destinationDir)
}

# Creating Testing file (Test.java)
Function CreateFile{
	Write-Host "Creating a testing file..."
}

# Main method, which is used to handle all global logic
Function Main{
	SetupArchitectureSpecifics
	
	# check if java is installed and if so, skip the installation:
	if(!(Test-Path -Path $global:destinationDir)){
		Write-Host "Installing Java..."
		InstallJava
	}
	
	CreateFile
}

# Entry point
Main