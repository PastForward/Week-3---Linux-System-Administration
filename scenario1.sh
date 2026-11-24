
#!/bin/bash
set -e

if [[ $EUID -ne 0 ]]; then
    echo "Please run with sudo."
    exit 1
fi

echo "Executing scenario..."

setfacl -m u:acl_alice:rw- /srv/acl-homework/one/notes.txt

setfacl -m g:acl_reviewers:r-x /srv/acl-homework/one

echo "Scenario complete."
