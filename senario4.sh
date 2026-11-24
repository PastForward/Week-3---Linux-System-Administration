
#!/bin/bash
set -e

if [[ $EUID -ne 0 ]]; then
    echo "Please run with sudo."
    exit 1
fi

echo "Executing scenario..."

if id lab_tempuser &>/dev/null; then
    echo "Scenario account already exists. Reset the VM first."
    exit 1
fi

useradd -m -s /bin/bash lab_tempuser

usermod -aG acl_reviewers lab_tempuser

passwd -l lab_tempuser

echo "Scenario complete."
