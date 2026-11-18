
# Incident 004: SSH Connection Refused

## 1. Incident Summary
SSH connection to localhost failed with a connection refused error.

## 2. Environment
- OS: Ubuntu 26.04.1 LTS
- Environment: WSL2
- SSH Server: OpenSSH
- Port: 22

## 3. Problem
Command:
ssh -o ConnectTimeout=5 praka@localhost

Error:
ssh: connect to host localhost port 22: Connection refused

## 4. Investigation
Checked SSH socket status:
sudo systemctl status ssh.socket

Identified that the SSH socket was stopped.

## 5. Root Cause
The SSH listening socket was inactive, so incoming connections were refused.

## 6. Resolution
Restarted the SSH socket:
sudo systemctl start ssh.socket

## 7. Verification
- SSH socket status: Active (listening)
- Port 22: Listening
- Local SSH login: Successful
- hostname: Prakashini
- whoami: praka

## 8. Learning
- Investigating SSH connection failures
- Understanding SSH socket activation
- Checking listening ports
- Restoring SSH connectivity
