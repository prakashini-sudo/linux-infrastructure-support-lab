
#!/usr/bin/env bash

# Linux Infrastructure Support Lab
# Automated Infrastructure Health Check

set -u
mkdir -p reports

REPORT_FILE="reports/health-report-$(date +%Y%m%d-%H%M%S).log"

exec > >(tee "$REPORT_FILE") 2>&1
warnings=0
critical=0

echo "=========================================="
echo "     LINUX INFRASTRUCTURE HEALTH CHECK"
echo "=========================================="

echo ""
echo "Date     : $(date)"
echo "Hostname : $(hostname)"
echo "Uptime   : $(uptime -p)"

# 1. SERVICE STATUS
echo ""
echo "------ SERVICE STATUS ------"

services=("apache2" "ssh.socket" "bind9")

for service in "${services[@]}"; do
    if systemctl is-active --quiet "$service"; then
        echo "[OK] $service is running"
    else
        echo "[CRITICAL] $service is not running"
        critical=$((critical + 1))
    fi
done

# 2. DISK USAGE
echo ""
echo "------ DISK USAGE ------"

if [ -n "${TEST_DISK_USAGE:-}" ]; then
    disk_usage=$TEST_DISK_USAGE
    echo "[TEST MODE] Simulated disk usage"
else
    df -h /
    disk_usage=$(df -P / | awk 'NR==2 {gsub("%","",$5); print $5}')
fi

if [[ ! "$disk_usage" =~ ^[0-9]+$ ]] || [ "$disk_usage" -gt 100 ]; then
    echo "[ERROR] Invalid disk usage value"
    critical=$((critical + 1))
elif [ "$disk_usage" -ge 90 ]; then
    echo "[CRITICAL] Disk usage is ${disk_usage}%"
    critical=$((critical + 1))
elif [ "$disk_usage" -ge 80 ]; then
    echo "[WARNING] Disk usage is ${disk_usage}%"
    warnings=$((warnings + 1))
else
    echo "[OK] Disk usage is ${disk_usage}%"
fi

# 3. MEMORY USAGE
echo ""
echo "------ MEMORY USAGE ------"

free -h

memory_usage=$(free | awk '/Mem:/ {printf "%.0f", ($2-$7)/$2*100}')

if [ "$memory_usage" -ge 90 ]; then
    echo "[CRITICAL] Memory usage is ${memory_usage}%"
    critical=$((critical + 1))
elif [ "$memory_usage" -ge 80 ]; then
    echo "[WARNING] Memory usage is ${memory_usage}%"
    warnings=$((warnings + 1))
else
    echo "[OK] Memory usage is ${memory_usage}%"
fi

# 4. FAILED SYSTEMD SERVICES
echo ""
echo "------ FAILED SYSTEMD SERVICES ------"

failed_services=$(systemctl --failed --no-legend)

if [ -z "$failed_services" ]; then
    echo "[OK] No failed services"
else
    echo "[WARNING] Failed services detected:"
    echo "$failed_services"
    warnings=$((warnings + 1))
fi

# 5. OVERALL HEALTH STATUS
echo ""
echo "------ OVERALL HEALTH STATUS ------"

if [ "$critical" -gt 0 ]; then
    echo "STATUS: CRITICAL"
elif [ "$warnings" -gt 0 ]; then
    echo "STATUS: WARNING"
else
    echo "STATUS: PASS"
fi

echo "Critical issues : $critical"
echo "Warnings        : $warnings"

echo ""
echo "=========================================="
echo "          HEALTH CHECK COMPLETE"
echo "=========================================="
