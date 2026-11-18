# Incident 009: Linux Permission Denied

## Problem
A user could not read access-test.txt.

## Symptoms
Command:
sudo -u nobody cat ~/linux-infrastructure-lab/documentation/access-test.txt

Result:
Permission denied.

## Investigation

File permissions:
-rw-r----- supportuser supportuser

Command:
namei -l /home/praka/linux-infrastructure-lab/documentation/access-test.txt

Finding:
The /home/praka directory had restrictive permissions.

ACL inspection:
getfacl /home/praka

Finding:
user:supportuser:--x

## Root Cause
The nobody user had no permission to traverse /home/praka.

## Verification

supportuser:
sudo -u supportuser cat ~/linux-infrastructure-lab/documentation/access-test.txt

Result:
Access successful.

nobody:
sudo -u nobody cat ~/linux-infrastructure-lab/documentation/access-test.txt

Result:
Permission denied.

## Resolution
No permission change was required.
The existing access restrictions were working as intended.

## Learning Outcomes
- Inspect ownership using ls -l.
- Understand Linux permission modes.
- Troubleshoot directory traversal.
- Inspect ACLs using getfacl.
- Use namei -l to identify path restrictions.
- Apply least-privilege access.
