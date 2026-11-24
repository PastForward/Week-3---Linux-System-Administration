
# Linux Security Investigation Homework
## ACLs & auditd

**Environment:** Ubuntu 24.04  
**Objective:** Learn how to investigate Linux permissions, Access Control Lists (ACLs), user accounts, and system modifications using `auditd`.

---

## Instructions

For each scenario:

1. Execute the provided scenario script.
2. Run the listed investigation commands.
3. Examine the command output.
4. Answer all questions using evidence from your system.
5. Explain what you believe happened.
6. Identify any potential security implications.

---

# Scenario 1 – Investigating File and Directory Permissions

## Step 1: Execute the Scenario

Run the following command:

```bash
sudo ./scenario1.sh
```

The scenario modifies two objects:

- `/srv/acl-homework/one/notes.txt`
- `/srv/acl-homework/one`

## Step 2: Investigate the File

Run:

```bash
sudo getfacl /srv/acl-homework/one/notes.txt
```

**Questions:**

1. Who owns this file?
2. What is the owner's permission level?
3. Is there another user listed in the ACL?
4. What permissions does that user have?
5. Why can a file have additional users listed in its permissions without changing its ownership?
6. What does the mask entry represent?
7. What does the other entry represent?

## Step 3: Investigate the Directory

Run:

```bash
getfacl /srv/acl-homework/one
```

**Questions:**

1. Who owns this directory?
2. What is the owning group?
3. What additional group is listed in the ACL?
4. What permissions does that group have?
5. What does the `r-x` permission combination allow someone to do?
6. Does having read and execute access to the directory automatically mean someone can modify files inside it?
7. What is the difference between directory permissions and file permissions?

## Step 4: Investigate the Audit Logs

Run:

```bash
sudo ausearch -k acl_lab -i --start today
```

**Questions:**

1. What files or directories appear in the audit records?
2. What executable was responsible for the modifications?
3. What user initiated the changes?
4. What timestamps are associated with the changes?
5. Why might multiple audit records belong to the same event?

---

# Scenario 2 – Investigating Default ACLs and Inheritance

## Step 1: Execute the Scenario

Run:

```bash
sudo ./scenario2.sh
```

The scenario modifies the following directory and creates two files:

- `/srv/acl-homework/two`
- `/srv/acl-homework/two/report.txt`
- `/srv/acl-homework/two/internal.txt`

## Step 2: Investigate the Directory

Run:

```bash
getfacl /srv/acl-homework/two
```

**Questions:**

1. Who owns the directory?
2. What is the owning group?
3. Which additional group appears in the ACL?
4. What permissions does this group have?
5. Do you see entries beginning with `default:`?
6. What do you think these default entries are used for?
7. How are default ACLs different from regular ACL entries?

## Step 3: Investigate the First File

Run:

```bash
getfacl /srv/acl-homework/two/report.txt
```

**Questions:**

1. Who owns this file?
2. What is the owning group?
3. Is the `acl_reviewers` group listed?
4. What permissions does the group have?
5. What does the effective permission annotation mean?
6. Does the group have permission to read the file?
7. Does the group have permission to modify the file?

## Step 4: Investigate the Second File

Run:

```bash
getfacl /srv/acl-homework/two/internal.txt
```

**Questions:**

1. Who owns this file?
2. What is the owning group?
3. Does it have the same ACL entries as `report.txt`?
4. Are the effective permissions identical?
5. Why might both files have inherited the same permissions?
6. What would happen if another file were created in this directory?

## Step 5: Investigate the Audit Logs

Run:

```bash
sudo ausearch -k acl_lab -i --start today
```

**Questions:**

1. What changes to the directory were recorded?
2. Can you identify the process responsible for the ACL modification?
3. Which user created the two files?
4. What timestamps are associated with the events?
5. Does the audit log show the same information as `getfacl`?
6. Why is it useful to investigate both audit logs and current permissions?

---

# Scenario 3 – Investigating ACL Masks

## Step 1: Execute the Scenario

Run:

```bash
sudo ./scenario3.sh
```

The scenario modifies:

- `/srv/acl-homework/three/record.txt`

## Step 2: Inspect the File

Run:

```bash
getfacl /srv/acl-homework/three/record.txt
```

**Questions:**

1. Who owns the file?
2. Is there an additional user listed in the ACL?
3. What permissions are assigned to `acl_alice`?
4. What permissions are listed under `mask`?
5. What does the effective permission annotation mean?
6. Why might the permissions assigned to a user differ from their effective permissions?
7. Does Alice have permission to read the file?
8. Does Alice have permission to modify the file?

## Step 3: Test the Permissions

Try reading the file as Alice:

```bash
sudo -u acl_alice cat /srv/acl-homework/three/record.txt
```

Then try modifying it:

```bash
sudo -u acl_alice bash -c 'echo test >> /srv/acl-homework/three/record.txt'
```

**Questions:**

1. Was Alice able to read the file?
2. Was Alice able to modify the file?
3. Why did one operation succeed while the other failed?
4. How did the ACL mask influence the result?

## Step 4: Investigate the Audit Logs

Run:

```bash
sudo ausearch -k acl_lab -i --start today
```

**Questions:**

1. What file was modified?
2. How many ACL modifications can you identify?
3. Which executable was responsible?
4. Who initiated the modifications?
5. What is the order of the changes?
6. Can you identify the timestamps?
7. How can you correlate multiple records belonging to the same event?

---

# Scenario 4 – Investigating User and Group Modifications

## Step 1: Execute the Scenario

Run:

```bash
sudo ./scenario4.sh
```

The scenario introduces a new account:

- `lab_tempuser`

## Step 2: Investigate the Account

Run:

```bash
getent passwd lab_tempuser
```

**Questions:**

1. What is the account's UID?
2. What is its primary GID?
3. What is its home directory?
4. What login shell is configured?
5. Does this appear to be a regular user or a system account?

## Step 3: Investigate Group Membership

Run:

```bash
id lab_tempuser
```

**Questions:**

1. What groups does this user belong to?
2. Is the user a member of `acl_reviewers`?
3. What additional access could this group membership provide?
4. Why should administrators regularly audit group memberships?

## Step 4: Investigate Password Status

Run:

```bash
sudo passwd -S lab_tempuser
```

Then run:

```bash
sudo grep '^lab_tempuser:' /etc/shadow
```

**Questions:**

1. What is the account's password status?
2. What does the `L` status indicate?
3. Does locking a password necessarily prevent SSH public-key authentication?

## Step 5: Investigate the Audit Logs

Run:

```bash
sudo ausearch -k identity_lab -i --start today
```

**Questions:**

1. What changes to `/etc/passwd` were recorded?
2. What changes to `/etc/group` were recorded?
3. What changes to `/etc/shadow` were recorded?
4. Can you identify the group modification?
5. What timestamps are associated with the changes?
6. Why is monitoring these files important during a security investigation?

---

# Final Investigation Questions

After completing all four scenarios, answer the following questions:

1. What is the difference between traditional Linux permissions and ACL permissions?
2. What is the difference between an access ACL and a default ACL?
3. What is an ACL mask?
4. What is the difference between assigned permissions and effective permissions?
5. What is the difference between a user ID and a group ID?
6. What is the difference between `/etc/passwd` and `/etc/shadow`?
7. What is `auditd` used for?
8. What is the difference between `auid` and `uid`?
9. What information can be found in a `SYSCALL` record?
10. What information can be found in a `PATH` record?
11. Why should administrators monitor changes to authentication and privilege files?
12. Why should audit logs and current system permissions both be examined during an investigation?

---

# Submission Requirements

For each scenario, submit the following:

- Answers to all questions.
- Screenshots of relevant `getfacl` output.
- Screenshots of relevant audit log entries (`ausearch`).
- Evidence of account and group investigations where applicable.
- A brief explanation of what happened.
- An explanation of the potential security implications.

> **Important:** Answers must be supported by evidence. Simply stating that a permission changed is not enough. Explain what changed, who was affected, and what the resulting permissions allow them to do.

---

# Bonus Challenge – Reversing the Changes

Research how an administrator could reverse the changes made during these exercises.

Explain how you would:

1. Remove individual ACL entries.
2. Remove default ACLs.
3. Restore traditional file permissions.
4. Remove unnecessary user accounts.
5. Remove unnecessary group memberships.
6. Unlock or disable accounts appropriately.
7. Verify that the system has returned to its original state.
