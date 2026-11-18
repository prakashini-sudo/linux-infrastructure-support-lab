# Incident 005: Apache Service Failure

## Problem
The lab.local website was unavailable.

## Symptoms
curl returned error 7:
Failed to connect to lab.local port 80.

## Investigation
Command:
sudo systemctl status apache2

Finding:
Apache was inactive (dead).

## Root Cause
The Apache service had been deliberately stopped during troubleshooting practice.

## Resolution
Command:
sudo systemctl start apache2

## Verification
Command:
systemctl status apache2 --no-pager

Result:
Active: active (running)

Website test:
curl -I http://lab.local

Result:
HTTP/1.1 200 OK

## Learning Outcomes
- Check service status before troubleshooting.
- Understand inactive and active service states.
- Restore a stopped service using systemctl.
- Verify recovery using an HTTP request.
