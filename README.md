# windows11-eligibility-check

## About
A PowerShell script that checks common requirements for upgrading from Windows 10 to Windows 11. This tool replicates core functionality of Microsoft’s PC Health Check app using native PowerShell commands.

> Important Note: It is NOT a definitive validator of Windows 11 compatibility — Microsoft maintains an official supported CPU list and the PC Health Check app which should be used for final validation.

## Features
The script evaluates key Windows 11 hardware requirements:
- CPU 
- System Architecture (64-bit)
- RAM (>= 4 GB)
- Storage / Disk Space (>= 64 GB free on system drive)
- System Firmware / UEFI + Secure Boot (UEFI)
- TPM version (TPM 2.0)
- OS Build (Windows 11 requires build >= 22000) 
- Graphics

## Usage:
** Admin privileges may be required to check some of the requirements.
- Run locally on Powershell with Admin Privileges:

  powershell -NoProfile -ExecutionPolicy Bypass -File .\check-w11.ps1

- Run with output to file:

  powershell -NoProfile -ExecutionPolicy Bypass -File .\check-w11.ps1 | Out-File results.txt

## Purpose
This project is a small demonstration of replicating PC Health App because some devices were blocked from downloading the app. I wanted to write a script to check the requirements. It is beginner-friendly but still shows practical skills in scripting and data handling. 
