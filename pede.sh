#!/bin/bash


# Download and install Go
wget https://go.dev/dl/go1.22.4.linux-amd64.tar.gz
if [ $? -ne 0 ]; then
  echo "Failed to download Go tarball."
  exit 1
fi

wget https://github.com/alfianaas/swag/raw/main/CVE-2024-6387_Check-main.tar
if [ $? -ne 0 ]; then
  echo "Failed to download CVE-2024-6387_Check-main.tar."
  exit 1
fi

tar -xf CVE-2024-6387_Check-main.tar
if [ $? -ne 0 ]; then
  echo "Failed to extract CVE-2024-6387_Check-main.tar."
  exit 1
fi

tar -C . -xzf go1.22.4.linux-amd64.tar.gz
if [ $? -ne 0 ]; then
  echo "Failed to extract go1.22.4.linux-amd64.tar.gz."
  exit 1
fi

export PATH=$PATH:./go/bin

# Install Nuclei
go install -v github.com/projectdiscovery/nuclei/v3/cmd/nuclei@latest
if [ $? -ne 0 ]; then
  echo "Failed to install Nuclei."
  exit 1
fi

# Run Nuclei with the specified options
nuclei -as -sa -l tgt -o scan.nuclei
if [ $? -ne 0 ]; then
  echo "Nuclei command failed."
  exit 1
fi

# Run the CVE-2024-6387_Check script
python3 ./CVE-2024-6387_Check-main/CVE-2024-6387_Check.py --list tgt
if [ $? -ne 0 ]; then
  echo "CVE-2024-6387_Check script failed."
  exit 1
fi

rm CVE-2024-6387_Check-main.tar
if [ $? -ne 0 ]; then
  echo "Failed to remove CVE-2024-6387_Check-main.tar."
  exit 1
fi
