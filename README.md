# windows11-eligibility-check
PowerShell script to check Windows 11 upgrade eligibility.

A small PowerShell script that checks common requirements for upgrading from Windows 10 to Windows 11. This tool replicates core functionality of Microsoft’s PC Health Check app using native PowerShell commands.

Usage:
- Run locally on Powershell with Admin Privileges:

  powershell -NoProfile -ExecutionPolicy Bypass -File .\check-w11.ps1

- Run with output to file:

  powershell -NoProfile -ExecutionPolicy Bypass -File .\check-w11.ps1 | Out-File results.txt

The script evaluates key Windows 11 hardware requirements:
- CPU model & generation
- Total RAM
- Disk space availability
- TPM version & availability
- Secure Boot status
- UEFI firmware check
- OS build information
- Clear pass/fail messages for each requirement

- TPM present and TPM spec version
- Secure Boot state (if measurable)
- Boot firmware mode (UEFI)
- OS build number (Windows 11 requires build >= 22000)
- System architecture (64-bit)
- Total physical memory (>= 4 GB)
- Free space on system drive (>= 64 GB)

Important Notes:

** Admin privileges may be required to check some of the requirements.

** It is NOT a definitive validator of Windows 11 compatibility — Microsoft maintains an official supported CPU list and the PC Health Check app which should be used for final validation.
