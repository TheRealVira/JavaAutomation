# Copyright (c) 2016, Vira
# All rights reserved.

# ---------------------------------

# Some need variables
$currentDir = $PSScriptRoot
$Arch = (Get-Process -Id $PID).StartInfo.EnvironmentVariables["PROCESSOR_ARCHITECTURE"];
$global:destinationDir = ""
$global:destinationDirJDK = ""
$global:fileName = ""
$global:fileNameJDK = ""
$global:source = $null # Global, because Powershell wants it to be ¯\_(ツ)_/¯
$global:sourceJDK = $null # Global, because Powershell wants it to be ¯\_(ツ)_/¯

$source86 = "http://download.oracle.com/otn-pub/java/jdk/8u102-b14/jre-8u102-windows-i586.exe"
$source64 = "http://download.oracle.com/otn-pub/java/jdk/8u102-b14/jre-8u102-windows-x64.exe"
$sourceJDK86 = "http://download.oracle.com/otn-pub/java/jdk/8u102-b14/jre-8u102-windows-i586.exe"
$sourceJDK64 = "http://download.oracle.com/otn-pub/java/jdk/8u102-b14/jdk-8u102-windows-x64.exe"

# Setup variables
Function SetupArchitectureSpecifics{
	If($Arch -eq 'x86'){
		Write-Host "You have an x86 system!"
		$global:source = $source86
		$global:sourceJDK = $sourceJDK86
		$global:destinationDir = "C:\Program Files (x86)\Java\jre1.8.0_102\"
		$global:destinationDirJDK = "C:\Program Files (x86)\Java\jdk1.8.0_102\"
		$global:fileNameJDK = "jdk-8u102-windows-i586.exe"
		$global:fileName = "jre-8u102-windows-i586.exe"
		
		return
	}
	
	Write-Host "You have an x64 system!"
	$global:source = $source64
	$global:sourceJDK = $sourceJDK64
	$global:destinationDir = "C:\Program Files\Java\jre1.8.0_102\"
		$global:destinationDirJDK = "C:\Program Files\Java\jdk1.8.0_102\"
	$global:fileNameJDK = "jdk-8u102-windows-x64.exe"
	$global:fileName = "jre-8u102-windows-x64.exe"
}

# Install the Java_Runtime_Environment
Function InstallJRE{
	Write-Host source
	Write-Host $$global:destinationDir
	$client = New-Object System.Net.WebClient
	# Single Example
	$client.Headers.Add([System.Net.HttpRequestHeader]::Cookie, "oraclelicense=accept-securebackup-cookie")
	$client.DownloadFile($source, "$($currentDir)\$($global:fileName)")
	
	& "$($currentDir)\$($global:fileName)"
	do{
		Read-Host 'The Java Runtime Environment isnt installed now, please come back after the installation finished...' | Out-Null
	}
	until(Test-Path -Path $global:destinationDir)
}

# Install the Java Development Kit
Function InstallJDK{
	Write-Host sourceJDK
	Write-Host $$global:destinationDirJDK
	$client = New-Object System.Net.WebClient
	# Single Example
	$client.Headers.Add([System.Net.HttpRequestHeader]::Cookie, "oraclelicense=accept-securebackup-cookie")
	$client.DownloadFile($sourceJDK, "$($currentDir)\$($global:fileNameJDK)")
	
	& "$($currentDir)\$($global:fileNameJDK)"
	do{
		Read-Host 'The Java Development Kit isnt installed now, please come back after the installation finished...' | Out-Null
	}
	until(Test-Path -Path $global:destinationDirJDK)
}

# Creating Testing file (Test.java)
Function CreateFile{
	Write-Host "Creating a testing file..."
}

# Main method, which is used to handle all global logic
Function Main{
	SetupArchitectureSpecifics
	
	# check if the jre is installed and if so, skip the installation:
	if(!(Test-Path -Path $global:destinationDir)){
		Write-Host "Installing the Java_Runtime_Environment..."
		InstallJRE
	}
	
	# check if the jdk is installed and if so, skip the installation:
	if(!(Test-Path -Path $global:destinationDirJDK)){
		Write-Host "Installing the Java Development Kit..."
		InstallJDK
	}
	
	CreateFile
}

# Entry point
Main