# DNS Server Configuration – BIND9

## 1. Objective
Install and configure BIND9 as a local DNS server.

## 2. Software Installed
- bind9
- bind9-utils
- bind9-dnsutils

## 3. DNS Server Configuration
DNS Server IP: 127.0.0.1
DNS Port: 53
Forwarders: 8.8.8.8 and 1.1.1.1

## 4. DNS Zone
Domain: lab.local
Zone Type: Master
Zone File: /etc/bind/db.lab.local

## 5. DNS Records
| Hostname | Record Type | IP Address |
|---|---|---|
| lab.local | A | 127.0.0.1 |
| www.lab.local | A | 127.0.0.1 |
| ns1.lab.local | A | 127.0.0.1 |

## 6. DNS Troubleshooting
Initial problem: DNS query returned SERVFAIL.

Root cause: BIND could not successfully resolve external domains using its initial configuration.

Resolution:
- Configured DNS forwarders.
- Validated configuration using named-checkconf.
- Restarted BIND9.
- Verified external DNS resolution.

## 7. WSL DNS Configuration
Updated /etc/wsl.conf:
generateResolvConf=false

Updated /etc/resolv.conf:
nameserver 127.0.0.1

## 8. Verification
- BIND9 service: Active
- DNS port 53: Listening
- lab.local: Resolved successfully
- www.lab.local: Resolved successfully
- Apache website: Accessible using curl http://lab.local

## 9. Learning Outcomes
- DNS server installation
- DNS forwarder configuration
- DNS zone management
- A and NS records
- DNS troubleshooting
- WSL DNS resolver configuration
- DNS and Apache integration
