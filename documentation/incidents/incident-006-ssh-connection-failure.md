# Incident 006: SSH Connection Failure

## Problem
Unable to connect to the local SSH server.

## Symptoms
SSH returned:
Connection refused on port 22.

## Investigation
Command:
sudo systemctl status ssh.socket --no-pager

Finding:
ssh.socket was inactive (dead).

## Root Cause
The SSH listening socket had been deliberately stopped during troubleshooting practice.

## Resolution
Command:
sudo systemctl start ssh.socket

## Verification
Command:
systemctl is-active ssh.socket

Result:
active

SSH login:
ssh praka@localhost

Verification:
whoami = praka
hostname = Prakashini

Result:
SSH login successful.

## Learning Outcomes
- Understand SSH socket activation.
- Check SSH service availability.
- Troubleshoot connection refused errors.
- Restore SSH connectivity.
- Verify login functionality.
