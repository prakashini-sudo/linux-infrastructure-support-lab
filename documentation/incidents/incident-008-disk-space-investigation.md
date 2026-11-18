# Incident 008: Disk Space Investigation

## Problem
Investigate a disk-space warning and identify storage usage.

## Investigation

Command:
df -h

Findings:
- Linux filesystem usage: 1%.
- Available Linux space: approximately 954 GB.
- Windows C: drive usage: 95%.
- Available C: drive space: approximately 11 GB.

## Directory Analysis

Command:
sudo du -xhd1 /var

Findings:
- /var/lib: 189 MB
- /var/cache: 122 MB
- /var/log: 66 MB

## Journal Analysis

Command:
sudo journalctl --disk-usage

Before cleanup:
64 MB

Cleanup:
sudo journalctl --vacuum-size=50M

Archived journal space freed:
16 MB

After cleanup:
48 MB

## Final Verification

Command:
df -h /

Result:
Linux filesystem usage remained at 1%, with approximately 954 GB available.

## Learning Outcomes
- Monitor filesystem capacity using df.
- Investigate directory sizes using du.
- Identify journal storage consumption.
- Manage archived journal files safely.
- Distinguish Windows mounted storage from the Linux filesystem.
