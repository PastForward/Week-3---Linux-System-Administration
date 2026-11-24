
#!/bin/bash
set -e

if [[ $EUID -ne 0 ]]; then
    echo "Please run with sudo."
    exit 1
fi

echo "Executing scenario..."

setfacl -m u:acl_alice:rw- /srv/acl-homework/three/record.txt

setfacl -m m::r-- /srv/acl-homework/three/record.txt

echo "Scenario complete."