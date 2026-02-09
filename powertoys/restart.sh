#!/bin/bash

set -e

echo "Stopping PowerToys..."
powershell.exe -Command "Stop-Process -Name 'PowerToys*' -Force -ErrorAction SilentlyContinue"

sleep 2

echo "Starting PowerToys..."
powershell.exe -Command "Start-Process -FilePath \"\$env:LOCALAPPDATA\PowerToys\PowerToys.exe\""

echo "PowerToys restarted successfully"
