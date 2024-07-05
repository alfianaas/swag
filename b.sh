#!/bin/bash

# Enable debug mode
set -x

# Step 1: Download Go
echo "Downloading Go..."
wget https://go.dev/dl/go1.22.4.linux-amd64.tar.gz

# Step 2: Remove any existing Go installation and extract the new Go tarball
echo "Removing existing Go installation and extracting the new one..."
rm -rf /usr/local/go && tar -C /usr/local -xzf go1.22.4.linux-amd64.tar.gz

# Step 3: Set up PATH for Go
echo "Setting up PATH for Go..."
export PATH=$PATH:/usr/local/go/bin

# Step 4: Check Go version
echo "Checking Go version..."
go version

# Step 5: Install nuclei
echo "Installing nuclei..."
go install -v github.com/projectdiscovery/nuclei/v3/cmd/nuclei@latest

# Step 6: Copy nuclei binary to /usr/local/go/bin
echo "Copying nuclei binary..."
cp /root/go/bin/nuclei /usr/local/go/bin/

# Disable debug mode
set +x
