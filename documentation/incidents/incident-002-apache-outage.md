# Incident 002: Apache Web Server Outage

## 1. Problem
The local website became unavailable.

## 2. Environment
- OS: Ubuntu 26.04.1 LTS
- Environment: WSL2
- Web Server: Apache 2.4.66
- Port: 80

## 3. Investigation
- Checked Apache service using systemctl status.
- Found the service inactive (dead).
- Tested the website using curl.
- Received connection failure on port 80.

## 4. Root Cause
Apache service was deliberately stopped during
a troubleshooting exercise.

## 5. Resolution
Started Apache using:

sudo systemctl start apache2

## 6. Verification
- Apache service returned to active state.
- curl -I http://localhost returned HTTP 200 OK.
- Website became accessible again.

## 7. Learning
Use systemctl to inspect and manage services.
Use curl to test HTTP availability.
