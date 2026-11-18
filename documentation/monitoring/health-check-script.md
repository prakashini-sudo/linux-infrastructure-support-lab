# Linux Infrastructure Health Check Automation

## 1. Overview

A Bash-based automation script that monitors essential Linux infrastructure components and generates timestamped health-check reports.

## 2. Features

- Checks Apache2, SSH socket and BIND9 service status.
- Monitors root filesystem disk usage.
- Monitors memory utilization using available memory.
- Detects failed systemd services.
- Classifies system health as PASS, WARNING or CRITICAL.
- Supports simulated disk usage for safe threshold testing.
- Generates timestamped reports automatically.

## 3. Technologies

- Ubuntu Linux on WSL2
- Bash scripting
- systemd
- Linux commands: `systemctl`, `df`, `free`, `awk`, `tee`

## 4. Alert Thresholds

| Metric | Warning | Critical |
|---|---:|---:|
| Disk usage | 80% | 90% |
| Memory usage | 80% | 90% |
| Apache2 / SSH / BIND9 | — | Inactive |
| Failed systemd services | Detected | — |

## 5. Execution

```bash
chmod +x scripts/health-check.sh
./scripts/health-check.sh
```

## 6. Simulation Tests

```bash
TEST_DISK_USAGE=50 ./scripts/health-check.sh
TEST_DISK_USAGE=85 ./scripts/health-check.sh
TEST_DISK_USAGE=95 ./scripts/health-check.sh
```

Expected results:

| Simulated disk usage | Expected status |
|---:|---|
| 50% | PASS |
| 85% | WARNING |
| 95% | CRITICAL |

Only disk usage is simulated. Other checks use the actual system.

## 7. Report Generation

Each execution creates a timestamped report in the `reports/` directory.

Example:

`reports/health-report-20261118-090113.log`

Generated reports are excluded from Git using `.gitignore`.

## 8. Project Outcome

Developed and tested a Linux infrastructure health-check automation script with service monitoring, resource utilization checks, alert thresholds and report generation.
