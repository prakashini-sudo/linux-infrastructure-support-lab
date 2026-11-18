
# Network and Firewall Configuration

## 1. Objective
Inspect network connectivity and configure UFW firewall on Ubuntu WSL2.

## 2. Network Configuration
- Interface: eth0
- IPv4: 172.17.178.185/20
- Default Gateway: 172.17.176.1
- Network: 172.17.176.0/20

## 3. Connectivity Tests
- Gateway ping: Successful
- Internet ping to 8.8.8.8: Successful with packet loss
- DNS resolution for google.com: Successful
- HTTPS request to Google: Successful

Note: ICMP packet loss was observed. HTTPS connectivity worked, so a general internet outage was not established.

## 4. Firewall Installation
Installed UFW:
sudo apt install ufw -y

## 5. Firewall Policies
- Incoming: Deny by default
- Outgoing: Allow by default
- Routed: Deny

## 6. Allowed Firewall Rules
| Service | Port | Protocol |
|---|---|---|
| SSH | 22 | TCP |
| Apache HTTP | 80 | TCP |

Both IPv4 and IPv6 rules were configured.

## 7. DNS Configuration
- DNS Server: BIND9
- DNS Port: 53
- Local DNS query: Successful
- DNS was not exposed globally through UFW.

## 8. Verification
- UFW status: Active
- SSH connection: Successful
- Apache service: Active
- Website response: HTTP 200 OK
- Local DNS query: NOERROR

## 9. Troubleshooting Exercise
Temporarily removed the Apache firewall rule and restored it.

Limitation:
Tests from inside the same WSL environment still returned HTTP 200. These tests did not establish whether an external machine would be blocked.

## 10. Learning Outcomes
- Network interface inspection
- Routing table analysis
- Gateway connectivity testing
- DNS and HTTPS troubleshooting
- UFW installation and configuration
- Firewall rule management
- SSH and Apache access control
