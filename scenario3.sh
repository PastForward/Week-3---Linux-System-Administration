#!/bin/bash
set -e

if [[ $EUID -ne 0 ]]; then
    echo "Please run with sudo."
    exit 1
fi

echo "Executing Scenario 3..."

# Allow Alice to traverse the parent directory
setfacl -m u:acl_alice:--x /srv/acl-homework

# Allow Alice to access directory three
setfacl -m u:acl_alice:rx /srv/acl-homework/three

# Grant Alice read-only access to record.txt
setfacl -m u:acl_alice:r-- /srv/acl-homework/three/record.txt

echo "Scenario 3 complete."