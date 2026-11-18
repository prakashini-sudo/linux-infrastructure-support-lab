# Incident 003: Apache Configuration Error

## Problem
Apache configuration test failed because of an invalid directive.

## Error
Invalid command 'InvalidDirective'

## Investigation
Ran:
sudo apache2ctl configtest

## Root Cause
An invalid directive was deliberately added to the lab.local.conf file during troubleshooting practice.

## Resolution
Removed the invalid directive and restored the correct VirtualHost configuration.

## Verification
- apache2ctl configtest: Syntax OK
- Apache reload: Successful
- curl -I http://lab.local: HTTP 200 OK

## Learning
Always run apache2ctl configtest before reloading or restarting Apache after configuration changes.
