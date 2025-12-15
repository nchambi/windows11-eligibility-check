# --- Windows 11 Upgrade Eligibility Check --- #
# This script checks if a Windows 10 device meets the minimum requirements to upgrade to Windows 11.

Write-Host "Checking Windows 11 upgrade requirements..." -ForegroundColor Cyan

# --- OS Version --- #

# Get the current OS build number
$OSBuild = [Environment]::OSVersion.Version.Build

# Check if the OS build is at least 22000 (minimum for Windows 11)
if ($OSBuild -ge 22000) {
    Write-Host "[PASS] OS build ($OSBuild) meets Windows 11 requirement"
} else {
    Write-Host "[FAIL] OS build ($OSBuild) is below 22000"
}

# --- Processor --- #

# Get information about the CPU
$ProcessorInfo = Get-WmiObject -Class Win32_Processor

$Name = $ProcessorInfo.Name                      # CPU name
$NumberOfCores = $ProcessorInfo.NumberOfCores    # Number of cores
$MaxGHz = ($ProcessorInfo.MaxClockSpeed) / 1000  # Max clock speed in GHz
$Processor = $ProcessorInfo.AddressWidth         # System architecture (32/64 bit)

# Check if CPU meets minimum requirements (1 GHz, 2 cores, 64-bit)
if ($MaxGHz -ge 1 -or $NumberOfCores -ge 2 -or $Processor -eq 64) {
    Write-Host "[PASS] CPU meets requirements"
} else {
    Write-Host "[FAIL] CPU does not meet requirements"
}

# --- RAM --- #

# Get total physical memory in GB
$RAMInfo = Get-CimInstance Win32_ComputerSystem
$RAM = ($RAMInfo.TotalPhysicalMemory) / 1GB

# Check if RAM is at least 4 GB
if ($RAM -ge 4) {
    Write-Host "[PASS] RAM meets requirements" 
} else {
    Write-Host "[FAIL] RAM is below 4 GB minimum"
}

# --- Secure Boot --- #

# Check if Secure Boot is enabled
try {
    $SecureBoot = Confirm-SecureBootUEFI
    if ($SecureBoot) {
        Write-Host "[PASS] Secure Boot is ENABLED"
    } else {
        Write-Host "[FAIL] Secure Boot is DISABLED"
    }
} catch {
    Write-Host "[WARN] Secure Boot status could not be determined"
}

# --- Total Disk Space --- #

# Get free space on system drive (C:)
$DriveInfo = Get-CimInstance -ClassName Win32_LogicalDisk -Filter "DeviceID='C:'"
$DiskSpace = $DriveInfo.FreeSpace #Get amount of disk space available

# Check if free space is at least 64 GB
if ($DiskSpace -ge 64 * 1GB) {
    Write-Host "[PASS] Storage meets requirements"
 } else { 
    Write-Host "[FAIL] Storage is below 64 GB minimum"
    }

# --- TPM --- #

# Get TPM information
$TPMInfo = Get-WmiObject -Namespace "Root\CIMv2\Security\MicrosoftTpm" -Class Win32_Tpm
$TPM = $TPMInfo.SpecVersion[0]

# Check if TPM version is 2.0
if ($TPM -eq "2") {
    Write-Host "[PASS] TPM meets 2.0 requirement" 
} else {
    Write-Host "[FAIL] TPM version is below 2.0"
}

# --- Graphics --- #

# Run dxdiag and export to a temporary text file to check DirectX version and WDDM driver
$dxdiag = "$env:TEMP\dxdiag.txt"
Start-Process -FilePath "dxdiag.exe" -ArgumentList "/t $dxdiag" -Wait
$dxOutput = Get-Content $dxdiag

# Check for DirectX 12 and WDDM 2.0 driver
if ($dxOutput -match "DirectX Version: DirectX 12" -and $dxOutput -match "Driver Model: WDDM 2") { # fix the driver model to be greater than not match
    Write-Host "[PASS] GPU supports DirectX 12 and WDDM 2.0 driver`n"
} else {
    Write-Host "[FAIL] GPU may not support DirectX 12 or WDDM 2.0`n"
}

Remove-Item $dxdiag -Force # Remove temporary dxdiag file

# --- Summary --- #
Write-Host "`nWindows 11 Upgrade Check Completed" -ForegroundColor Cyan

