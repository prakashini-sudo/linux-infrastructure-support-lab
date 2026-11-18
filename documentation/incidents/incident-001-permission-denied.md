# Incident 001: Linux File Permission Denied

## 1. Problem
The user praka received a Permission denied error
when attempting to read access-test.txt.

## 2. Environment
- OS: Ubuntu 26.04.1 LTS
- Environment: WSL2
- Project: Linux Infrastructure Support Lab

## 3. Investigation
- Checked file ownership using ls -l.
- Inspected directory permissions using namei -l.
- Found that /home/praka did not allow access to supportuser.

## 4. Root Cause
The supportuser account could not traverse the
/home/praka directory.

## 5. Resolution
Installed ACL utilities and granted execute-only
access to supportuser on /home/praka.

Command:
sudo setfacl -m u:supportuser:--x /home/praka

## 6. Verification
- Checked ACL using getfacl.
- Switched to supportuser.
- Successfully read the test file.
- Successfully appended content to the file.

## 7. Learning
Linux checks permissions on every directory in a
file path. ACLs allow specific permissions for
individual users without changing standard permissions.
