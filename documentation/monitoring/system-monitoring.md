# System Monitoring and Log Analysis

## 1. System Resource Monitoring

### CPU and Load
- Tool: top
- CPU was approximately 99.9% idle.
- Load average was close to zero.
- No significant CPU pressure was observed.

### Memory and Swap
- Total RAM: 7.4 GiB
- Available RAM: approximately 6.8 GiB
- Swap: 2 GiB
- Swap used: 0 B

## 2. Disk Monitoring

Tool: df -h

- Linux filesystem usage: approximately 1%.
- Windows C: drive usage: approximately 95%.
- Project stored in Linux home directory.

Tool: df -i

- Inode usage: approximately 1%.

## 3. Disk Usage Investigation

Tool: du -h --max-depth=1 ~

- Inspected home directory usage.
- Project directory size was approximately 68 KB at the time of inspection.

## 4. Service Health

Tool: systemctl --failed

- No failed systemd units were reported.

## 5. Apache Log Analysis

### Access Log
Location: /var/log/apache2/lab-access.log

Observed:
- HTTP 200 responses for successful requests.
- HTTP 404 response for the missing /not-found resource.

### Error Log
Location: /var/log/apache2/lab-error.log

- No entries were recorded during inspection.

## 6. System Journal

Tool: journalctl

- Inspected recent system journal entries.
- Observed WSL Ubuntu Pro service warnings related to its Windows agent connection.
- These warnings did not indicate an Apache, SSH, DNS, or firewall failure.

## 7. Troubleshooting Commands

- top
- free -h
- df -h
- df -i
- du -h --max-depth=1 ~
- journalctl -n 20 --no-pager
- systemctl --failed
- tail

## 8. Learning Outcomes

- Monitor CPU, memory, swap, disk, and inode usage.
- Inspect system services and journal logs.
- Distinguish HTTP 200 and 404 responses.
- Identify the correct Apache virtual-host log files.
- Recognize the difference between a warning and a service failure.
