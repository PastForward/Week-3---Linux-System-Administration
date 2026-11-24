#!/bin/bash
set -e

if [[ $EUID -ne 0 ]]; then
    echo "Please run with sudo."
    exit 1
fi

echo "Executing scenario..."

# Allow acl_reviewers to traverse the parent directory
setfacl -m g:acl_reviewers:--x /srv/acl-homework

# Allow acl_reviewers to access and create files in directory two
setfacl -m g:acl_reviewers:rwx /srv/acl-homework/two

# Set default ACL for newly created files and directories
setfacl -d -m g:acl_reviewers:r-x /srv/acl-homework/two

# Create files as acl_bob
runuser -u acl_bob -- bash -c \
    'echo "Quarterly Review Document" > /srv/acl-homework/two/report.txt'

runuser -u acl_bob -- bash -c \
    'echo "Confidential Information" > /srv/acl-homework/two/internal.txt'

echo "Scenario complete."
