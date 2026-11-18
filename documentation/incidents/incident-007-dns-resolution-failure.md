# Incident 007: DNS Resolution Failure

## Problem
The hostname lab.local could not be resolved.

## Symptoms
Command:
getent hosts lab.local

Result:
No output.

## Investigation

Checked DNS configuration:
cat /etc/resolv.conf

Result:
nameserver 127.0.0.1

Checked DNS service:
sudo systemctl status bind9 --no-pager

Finding:
BIND9 was inactive (dead).

## Root Cause
The BIND9 DNS service had been deliberately stopped.

## Resolution
sudo systemctl start bind9

## Verification

Service:
systemctl is-active bind9

Result:
active

DNS lookup:
getent hosts lab.local

Result:
127.0.0.1 lab.local

Website:
curl -I http://lab.local

Result:
HTTP/1.1 200 OK

## Learning Outcomes
- Understand local DNS resolution.
- Inspect /etc/resolv.conf.
- Check BIND9 service status.
- Troubleshoot DNS resolution failures.
- Verify DNS and dependent website connectivity.
