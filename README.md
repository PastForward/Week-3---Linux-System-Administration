# Linux Security Investigation Lab
### ACLs, User Accounts & auditd

A hands-on Linux security investigation lab designed for **Ubuntu 24.04**. This repository contains scenario scripts that simulate changes to file permissions, Access Control Lists (ACLs), user accounts, and group memberships.

## Overview

The lab focuses on developing practical Linux system administration and security investigation skills. Each scenario introduces system changes that students must investigate using native Linux tools and audit logs.

## Repository Contents

| File | Description |
|---|---|
| `setup_homework.sh` | Prepares the lab environment, installs required packages, creates users and groups, builds homework directories, and configures audit rules. |
| `scenario1.sh` | Introduces traditional file and directory permissions and named ACL entries. |
| `scenario2.sh` | Demonstrates default ACLs, permission inheritance, and file creation. |
| `scenario3.sh` | Explores ACL masks, effective permissions, and user-specific access restrictions. |
| `scenario4.sh` | Introduces user account creation, group membership modifications, and password locking. |
| `homework.md` | Contains the full homework instructions, investigation commands, questions, and submission requirements. |

## Scenarios

### Before running the Scenarios, ensure that the setup_homework.sh file was run before. This will download all the dependencies needed for this homework.

### Scenario 1 – File and Directory Permissions
- Investigating traditional Linux permissions and ownership.
- Understanding named users and groups in ACLs.
- Examining file and directory permission differences.
- Investigating permission changes through `auditd`.

### Scenario 2 – Default ACLs and Inheritance
- Understanding default ACLs.
- Investigating inherited permissions on newly created files.
- Comparing access ACLs and default ACLs.
- Identifying file creation and permission changes in audit logs.

### Scenario 3 – ACL Masks
- Investigating ACL masks and effective permissions.
- Understanding assigned versus effective permissions.
- Testing read and write access for individual users.
- Identifying how ACL masks restrict access.

### Scenario 4 – User and Group Modifications
- Investigating Linux user account creation.
- Examining UID and GID assignments.
- Identifying group memberships and associated access.
- Investigating password status and account modifications.
- Monitoring changes to authentication-related system files.


## Tools & Commands Covered

| Tool | Purpose |
|---|---|
| `getfacl` / `setfacl` | Inspect and modify ACL permissions |
| `ls -l` | Examine traditional Linux permissions |
| `id` / `getent` | Investigate users and groups |
| `passwd` | Examine account password status |
| `ausearch` | Investigate audit logs |
| `auditd` | Monitor system activity and modifications |
| `namei` | Investigate directory traversal permissions |

## Setup & Installation

The `setup_homework.sh` script prepares the Ubuntu environment for all four scenarios.

It performs the following tasks:

- Installs `acl`, `auditd`, and `audispd-plugins`.
- Enables and starts the audit service.
- Creates the `acl_reviewers` group.
- Creates the `acl_alice` and `acl_bob` accounts.
- Adds `acl_bob` to the `acl_reviewers` group.
- Creates the homework directory structure under `/srv/acl-homework`.
- Creates the initial homework files.
- Configures audit rules for ACL-related and identity-related system modifications.

### Running the Setup Script

Make the scripts executable:
```bash
chmod +x *.sh
```

Run the setup script with root privileges:

```bash
sudo ./setup_homework.sh
```

then you can run the senarios.

## Homework Instructions

For the complete assignment instructions, investigation steps, questions, and submission requirements, refer to:

**[View Homework Instructions](homework.md)**

The homework document provides detailed guidance for each scenario, including the commands students should execute, the evidence they should collect, and the questions they must answer.


## Environment

- **Operating System:** Ubuntu 24.04
- **Privileges:** Root / sudo access
- **Auditing:** Linux Audit Framework (`auditd`)
- **Scripts:** Bash

## Usage

Clone the repository in a Virtual Machine:

```bash
git clone https://github.com/PastForward/Week-3---Linux-System-Administration
cd https://github.com/PastForward/Week-3---Linux-System-Administration
```