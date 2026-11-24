#!/bin/bash
set -e

if [[ $EUID -ne 0 ]]; then
    echo "Please run with sudo."
    exit 1
fi

echo "Executing scenario..."

# Remove existing scenario account if present
if id lab_tempuser &>/dev/null; then
    userdel -r lab_tempuser
fi

# Create scenario account
useradd -m -s /bin/bash lab_tempuser

# Add user to reviewers group
usermod -aG acl_reviewers lab_tempuser

# Lock the account password
passwd -l lab_tempuser

echo "Scenario complete."