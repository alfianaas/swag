#!/bin/bash

echo "    ____                                _       _   _ _                     _ "
echo "   / __ \__      ____ _ _ __ __ _  __ _(_)_ __ | |_(_) |__  _   _ _ __ ___ (_)"
echo "  / / _\` \\ \\ /\\ / / _\` | '__/ _\` |/ _\` | | '_ \\| __| | '_ \\| | | | '_ \` _ \\| |"
echo " | | (_| |\\ V  V / (_| | | | (_| | (_| | | | | | |_| | |_) | |_| | | | | | | |"
echo "  \\ \\__,_| \\_/\\_/ \\__,_|_|  \\__, |\\__,_|_|_| |_|\\__|_|_.__/ \\__,_|_| |_| |_|_|"
echo "   \\____/                   |___/                                             "
echo "                                    © 2024"

# Set cache dir owner
sudo chown -R $(whoami):$(whoami) /home/$(whoami)/.cache/

# Download and install Go
wget https://go.dev/dl/go1.22.4.linux-amd64.tar.gz

# Download Regresshion Checker
wget https://github.com/alfianaas/swag/raw/main/CVE-2024-6387_Check-main.tar

# Extract Regresshion Checker
tar -xf CVE-2024-6387_Check-main.tar

# Extract go
tar -C . -xzf go1.22.4.linux-amd64.tar.gz



# Install Nuclei
./go/bin/go install -v github.com/projectdiscovery/nuclei/v3/cmd/nuclei@latest

# Run Nuclei with the specified options
./go/bin/nuclei
sudo chown -R $(whoami):$(whoami) /home/$(whoami)/nuclei-templates
./go/bin/nuclei -as -sa -l tgt -o scan.nuclei

nuclei_exit_status=$?

# Run the CVE-2024-6387_Check script
$(which python3) ./CVE-2024-6387_Check-main/CVE-2024-6387_Check.py --list tgt

# Delete CVE Checker
rm CVE-2024-6387_Check-main.tar
