# Linux Infrastructure Support & Troubleshooting Lab

A hands-on Linux infrastructure administration and troubleshooting project built using Ubuntu on WSL2. This project demonstrates practical skills in Linux system administration, service management, networking, DNS, SSH, Apache, firewall configuration, monitoring, Bash automation, and incident troubleshooting.

## Project Overview

The objective of this project is to simulate common Linux infrastructure support activities and develop practical troubleshooting skills through configuration, testing, incident investigation, and automation.

## Environment

| Component | Details |
|---|---|
| Operating System | Ubuntu 26.04.1 LTS |
| Environment | WSL2 |
| Kernel | Linux 6.6 |
| Shell | Bash |
| Version Control | Git and GitHub |

## Technologies & Tools

- Linux Administration – Ubuntu, users, groups, permissions, ACLs
- Networking – IP configuration, routing, connectivity troubleshooting
- DNS – BIND9, DNS records, forwarders, name resolution
- Web Server – Apache2, virtual hosts, HTTP troubleshooting
- Remote Access – OpenSSH, SSH configuration and troubleshooting
- Firewall – UFW
- Monitoring – `top`, `free`, `df`, `du`, `journalctl`, `systemctl`
- Automation – Bash scripting
- Version Control – Git and GitHub

## Infrastructure Components

### 1. Linux User and Permission Management

- Created and managed Linux users and groups.
- Practiced file ownership and permissions.
- Configured and tested Access Control Lists (ACLs).
- Investigated permission-denied errors.
- Verified directory traversal permissions.

### 2. Apache Web Server Administration

- Installed and configured Apache2.
- Created a custom virtual host.
- Configured a local web application directory.
- Tested HTTP connectivity using curl.
- Troubleshot service failures, configuration errors, and HTTP 404 responses.

### 3. DNS Server Configuration

- Installed and configured BIND9.
- Created a local DNS zone.
- Configured SOA, NS, and A records.
- Configured DNS forwarders.
- Validated DNS configuration using `named-checkconf`, `named-checkzone`, and `dig`.
- Troubleshot DNS resolution failures.

### 4. SSH Remote Access

- Installed and configured OpenSSH Server.
- Verified SSH socket activation.
- Inspected effective SSH configuration.
- Validated SSH configuration using `sshd -t`.
- Tested local SSH connectivity.
- Troubleshot connection failures.

### 5. Networking and Firewall

- Inspected network interfaces and routing tables.
- Tested network connectivity.
- Configured UFW firewall rules.
- Allowed SSH and HTTP access.
- Verified service connectivity after firewall configuration.

### 6. System Monitoring and Troubleshooting

- Monitored CPU, memory, disk, and swap utilization.
- Inspected systemd service states.
- Investigated failed services.
- Analyzed system logs using journalctl.
- Performed journal log cleanup.
- Investigated disk-space utilization.

## Automated Linux Infrastructure Health Check

Developed a Bash script to automate basic Linux infrastructure health checks.

**Script:** `scripts/health-check.sh`

**Features:**
- Apache2, SSH socket, and BIND9 service monitoring.
- Root filesystem disk usage monitoring.
- Memory utilization monitoring using available memory.
- Failed systemd service detection.
- Overall health classification: PASS, WARNING, CRITICAL.
- Simulated disk usage for threshold testing.
- Automatic timestamped health-check report generation.

**Alert thresholds:**

| Metric | Warning | Critical |
|---|---:|---:|
| Disk usage | 80% | 90% |
| Memory usage | 80% | 90% |
| Monitored services | — | Inactive |

**Execution:**

```bash
chmod +x scripts/health-check.sh
./scripts/health-check.sh
```

**Simulation testing:**

```bash
TEST_DISK_USAGE=50 ./scripts/health-check.sh
TEST_DISK_USAGE=85 ./scripts/health-check.sh
TEST_DISK_USAGE=95 ./scripts/health-check.sh
```

Expected results:

| Simulated Disk Usage | Expected Status |
|---:|---|
| 50% | PASS |
| 85% | WARNING |
| 95% | CRITICAL |

Only disk usage is simulated; service and memory checks use the actual environment.

Generated reports are stored in `reports/` and excluded from Git.

Detailed documentation: [Health Check Automation](documentation/monitoring/health-check-script.md)

## Incident Troubleshooting Reports

Documented nine practical troubleshooting exercises.

| Incident | Scenario |
|---|---|
| 001 | Linux permission denied |
| 002 | Apache service outage |
| 003 | Apache configuration error |
| 004 | SSH connection refused |
| 005 | Apache service failure |
| 006 | SSH connection failure |
| 007 | DNS resolution failure |
| 008 | Disk-space investigation |
| 009 | Permission-denied investigation |

Detailed incident reports are available in `documentation/incidents/`.

## Project Structure

```text
linux-infrastructure-support-lab/
│
├── README.md
├── .gitignore
│
├── configs/
│   ├── apache/
│   │   └── lab.local.conf
│   ├── bind9/
│   │   ├── db.lab.local
│   │   └── named.conf.local
│   └── ssh/
│       └── sshd_config
│
├── scripts/
│   └── health-check.sh
│
├── documentation/
│   ├── dns/
│   │   └── dns-setup.md
│   ├── incidents/
│   │   ├── incident-001-permission-denied.md
│   │   ├── incident-002-apache-outage.md
│   │   ├── incident-003-apache-config-error.md
│   │   ├── incident-004-ssh-connection-refused.md
│   │   ├── incident-005-apache-service-failure.md
│   │   ├── incident-006-ssh-connection-failure.md
│   │   ├── incident-007-dns-resolution-failure.md
│   │   ├── incident-008-disk-space-investigation.md
│   │   └── incident-009-permission-denied.md
│   ├── monitoring/
│   │   ├── system-monitoring.md
│   │   └── health-check-script.md
│   ├── network/
│   │   └── network-firewall-setup.md
│   └── ssh/
│       ├── ssh-effective-config.md
│       └── ssh-setup.md
│
└── reports/
    └── Generated health-check reports (not tracked by Git)
```

## Important Commands Practiced

```bash
# System information
hostname
uptime
free -h
df -h
du -sh

# Service management
systemctl status apache2
systemctl is-active ssh.socket
systemctl --failed

# Logs
journalctl -xe
journalctl --disk-usage

# Networking
ip addr
ip route
ping
ss -tuln

# DNS
dig lab.local
named-checkconf
named-checkzone lab.local /etc/bind/db.lab.local

# Apache
apache2ctl configtest
curl -I http://lab.local

# SSH
sshd -t
ssh praka@localhost

# Firewall
sudo ufw status verbose
```

## Key Learning Outcomes

- Linux system administration and troubleshooting.
- Service management using systemd.
- User and permission management.
- DNS and web server configuration.
- SSH remote access administration.
- Basic network and firewall troubleshooting.
- System resource monitoring and log analysis.
- Bash scripting and infrastructure health-check automation.
- Incident documentation and version control.

## Environment Limitations

This project was developed in WSL2 Ubuntu. It demonstrates Linux administration and troubleshooting in a local lab environment. It does not represent a production server deployment or a high-availability infrastructure environment.

## Author

**Prakashini B**
