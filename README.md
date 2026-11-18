
# Linux Infrastructure Support & Troubleshooting Lab

A hands-on Linux infrastructure administration project built using Ubuntu on WSL2. This lab demonstrates practical Linux system administration, service configuration, network troubleshooting, access control, monitoring, and incident resolution.

## Project Overview

The objective of this project is to simulate real-world Linux infrastructure support activities, investigate service failures, identify root causes, implement fixes, and document troubleshooting procedures.

## Environment

| Component | Details |
|---|---|
| OS | Ubuntu 26.04.1 LTS |
| Environment | WSL2 |
| Kernel | Linux 6.6 |
| Shell | Bash |
| Service Manager | systemd |
| Web Server | Apache2 |
| DNS Server | BIND9 |
| Remote Access | OpenSSH |
| Firewall | UFW |

## Technologies & Tools

- Linux system administration
- Apache Web Server
- BIND9 DNS
- OpenSSH
- UFW Firewall
- systemd and journalctl
- Linux users, groups and ACLs
- Networking and IP troubleshooting
- Disk and system monitoring
- Git and GitHub

## Infrastructure Components

### 1. Linux Administration
- User and group management
- File ownership and permissions
- Access Control Lists (ACL)
- Package management
- Service management

### 2. Apache Web Server
- Apache installation and configuration
- Virtual host configuration
- Website deployment
- Access and error log analysis
- HTTP response troubleshooting

### 3. DNS Server
- BIND9 installation
- DNS forwarding configuration
- Local DNS zone configuration
- DNS record management
- DNS resolution troubleshooting

### 4. SSH Server
- OpenSSH server installation
- SSH socket activation
- Local SSH authentication
- Connection failure troubleshooting

### 5. Network and Firewall
- IP address and routing inspection
- Connectivity testing
- UFW configuration
- Incoming and outgoing firewall policies
- Port and service verification

### 6. System Monitoring
- CPU and memory monitoring
- Disk and inode usage
- Journal log analysis
- Service health checks
- Apache log analysis

## Incident Management & Troubleshooting

| Incident | Problem |
|---|---|
| 001 | Permission denied investigation |
| 002 | Apache service outage |
| 003 | Apache configuration error |
| 004 | SSH connection refused |
| 005 | Apache service failure |
| 006 | SSH connection failure |
| 007 | DNS resolution failure |
| 008 | Disk space investigation |
| 009 | Linux permission denied |

Each incident includes investigation steps, root cause, resolution or verification, and learning outcomes.

## Important Commands Practiced

```bash
systemctl status
systemctl restart
journalctl -xe
df -h
du -sh
free -h
top
ip addr
ip route
ss -tulpn
ping
curl
dig
getent hosts
chmod
chown
setfacl
getfacl
namei -l
```

## Project Structure

```text
linux-infrastructure-lab/
├── configs/
│   ├── apache/
│   ├── bind9/
│   └── ssh/
├── documentation/
│   ├── dns/
│   ├── incidents/
│   ├── monitoring/
│   ├── network/
│   ├── setup/
│   └── ssh/
├── logs/
├── scripts/
├── screenshots/
└── README.md
```

## Learning Outcomes

- Perform Linux system administration tasks.
- Configure and troubleshoot infrastructure services.
- Diagnose service and connectivity failures.
- Investigate file permission and ACL problems.
- Monitor system resources and logs.
- Document incidents using a structured troubleshooting approach.

## Environment Limitations

This project was developed in WSL2. Service availability and networking behavior may differ from a production Linux server or cloud VM. Testing was primarily performed locally.

## Project Status

Technical lab modules and five additional troubleshooting simulations completed. Configuration examples, evidence collection, and GitHub publication are being organized.

## Author

Prakashini B.

Aspiring Linux Infrastructure Support / Cloud Support Engineer.
