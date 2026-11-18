
# SSH Server Setup and Troubleshooting

## 1. Objective
Install and configure OpenSSH Server on Ubuntu WSL2.

## 2. Software Installed
- openssh-server
- openssh-client

## 3. SSH Configuration
- SSH Port: 22
- SSH Protocol: TCP
- SSH User: praka
- SSH Host: localhost

## 4. Service Verification
- SSH socket: Active and listening
- SSH configuration test: Passed using sshd -t
- Port verification: ss -tulpn
- Local SSH login: Successful

## 5. Connection Test
Command:
ssh praka@localhost

Verification:
- hostname returned Prakashini
- whoami returned praka
- SSH login and logout successful

## 6. Troubleshooting
Problem:
Connection refused when connecting to localhost.

Root Cause:
SSH socket was stopped.

Resolution:
Started the SSH socket using:
sudo systemctl start ssh.socket

Verification:
- SSH socket active
- Port 22 listening
- SSH login successful

## 7. Learning Outcomes
- SSH server installation
- SSH socket activation
- SSH service management
- SSH configuration validation
- Port 22 verification
- SSH connection troubleshooting
