# Copyright (c) 2016, Vira
# All rights reserved.

# ---------------------------------

# Some need variables
$currentDir = $PSScriptRoot
$Arch = (Get-Process -Id $PID).StartInfo.EnvironmentVariables["PROCESSOR_ARCHITECTURE"];
$destinationDir = ""
$fileName = ""
$global:source = $null # Global, because Powershell wants it to be ¯\_(ツ)_/¯

$source86 = "http://download.oracle.com/otn-pub/java/jdk/8u102-b14/jre-8u102-windows-i586.exe"
$source64 = "http://download.oracle.com/otn-pub/java/jdk/8u102-b14/jre-8u102-windows-x64.exe"

# Setup variables
Function SetupArchitectureSpecifics{
	If($Arch -eq 'x86'){
		Write-Host "You have an x86 system!"
		$global:source = $source86
		$destinationDir = "C:\Program Files (x86)\Java\"
		$fileName = "jre-8u102-windows-i586.exe"
		
		return
	}
	
	Write-Host "You have an x64 system!"
	$global:source = $source64
	$destinationDir = "C:\Program Files\Java\"
	$fileName = "jre-8u102-windows-x64.exe"
}

# Install Java
Function InstallJava{
	curl -outf $currentDir $source
}

# Creating Testing file (Test.java)
Function CreateFile{
	Write-Host "Creating a testing file..."
}

# Main method, which is used to handle all global logic
Function Main{
	SetupArchitectureSpecifics
	
	# check if java is installed and if so, skip the installation:
	if(!(Test-Path -Path destinationDir)){
		Write-Host "Installing Java..."
		InstallJava
	}
	
	CreateFile
}

# Entry point
Main