
#!/bin/bash
set -e

echo "======================================"
echo " Linux ACL & auditd Homework Setup"
echo "======================================"

# Ensure script runs as root
if [[ $EUID -ne 0 ]]; then
    echo "Please run this script with sudo."
    exit 1
fi

echo "[1/5] Installing required packages..."
apt update
apt install -y acl auditd audispd-plugins

echo "[2/5] Enabling auditd..."
systemctl enable --now auditd

echo "[3/5] Creating users and groups..."

groupadd -f acl_reviewers

id acl_alice &>/dev/null || useradd -m -s /bin/bash acl_alice
id acl_bob &>/dev/null || useradd -m -s /bin/bash acl_bob

usermod -aG acl_reviewers acl_bob

echo "[4/5] Creating homework directories..."

mkdir -p /srv/acl-homework/{one,two,three}

touch /srv/acl-homework/one/notes.txt
touch /srv/acl-homework/three/record.txt

chown -R root:root /srv/acl-homework
chmod -R 770 /srv/acl-homework

echo "[5/5] Configuring audit rules..."

cat > /etc/audit/rules.d/homework.rules <<'EOF'
-w /etc/passwd -p wa -k identity_lab
-w /etc/shadow -p wa -k identity_lab
-w /etc/group -p wa -k identity_lab
-w /etc/gshadow -p wa -k identity_lab

-w /srv/acl-homework/one -p wa -k acl_lab
-w /srv/acl-homework/one/notes.txt -p wa -k acl_lab

-w /srv/acl-homework/two -p wa -k acl_lab

-w /srv/acl-homework/three -p wa -k acl_lab
-w /srv/acl-homework/three/record.txt -p wa -k acl_lab
EOF

augenrules --load

echo ""
echo "======================================"
echo " Setup Complete!"
echo "======================================"

echo "Auditd status:"
systemctl is-active auditd

echo ""
echo "Loaded audit rules:"
auditctl -l

echo ""
echo "Homework environment is ready."
echo "Do NOT run the investigation scenarios yet."
