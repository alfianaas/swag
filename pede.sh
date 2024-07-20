#!/bin/bash

# Download and install Go
wget https://go.dev/dl/go1.22.4.linux-amd64.tar.gz
tar -C . -xzf go1.22.4.linux-amd64.tar.gz
export PATH=$PATH:/root/go/bin

# Install Nuclei
go install -v github.com/projectdiscovery/nuclei/v3/cmd/nuclei@latest

# Clone the CVE-2024-6387_Check repository
git clone https://github.com/xaitax/CVE-2024-6387_Check.git

# Run Nuclei with the specified options
nuclei -as -sa -l tgt -o scan.nuclei

# Run the CVE-2024-6387_Check script
python3 ./CVE-2024-6387_Check/CVE-2024-6387_Check.py --list tgt
