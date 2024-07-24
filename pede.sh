#!/bin/bash

# Download and install Go
wget https://go.dev/dl/go1.22.4.linux-amd64.tar.gz
wget https://github.com/alfianaas/swag/raw/main/CVE-2024-6387_Check-main.tar
tar -xf CVE-2024-6387_Check-main.tar
tar -C . -xzf go1.22.4.linux-amd64.tar.gz
export PATH=$PATH:./go/bin

# Install Nuclei
go install -v github.com/projectdiscovery/nuclei/v3/cmd/nuclei@latest

# Run Nuclei with the specified options
nuclei -as -sa -l tgt -o scan.nuclei

# Run the CVE-2024-6387_Check script
python3 ./CVE-2024-6387_Check-main/CVE-2024-6387_Check.py --list tgt

rm CVE-2024-6387_Check-main.tar
