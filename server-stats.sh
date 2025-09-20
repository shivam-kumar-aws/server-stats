#!/bin/bash
# server-stats.sh
# Script to display basic server performance stats

echo "================= SERVER PERFORMANCE STATS ================="
echo "Hostname     : $(hostname)"
echo "OS Version   : $(uname -srm)"
echo "Uptime       : $(uptime -p)"
echo "Load Average : $(uptime | awk -F'load average:' '{ print $2 }')"
echo "Logged in Users: $(who | wc -l)"
echo "------------------------------------------------------------"

# CPU Usage
echo "[CPU USAGE]"
cpu_idle=$(top -bn1 | grep "Cpu(s)" | awk '{print $8}' | cut -d',' -f1)
cpu_usage=$(echo "100 - $cpu_idle" | bc)
echo "Total CPU Usage: $cpu_usage%"

# Memory Usage
echo ""
echo "[MEMORY USAGE]"
free -h | awk 'NR==1{print $0} NR==2{print "Used: "$3" | Free: "$4" | Total: "$2}'
mem_usage=$(free | awk '/Mem/ {printf("%.2f"), $3/$2*100}')
echo "Memory Usage: $mem_usage%"

# Disk Usage
echo ""
echo "[DISK USAGE]"
df -h --total | awk '/total/ {print "Used: "$3" | Free: "$4" " | Total: "$2" | Usage: "$5}'

# Top Processes by CPU
echo ""
echo "[TOP 5 PROCESSES BY CPU USAGE]"
ps -eo pid,comm,%cpu,%mem --sort=-%cpu | head -n 6

# Top Processes by Memory
echo ""
echo "[TOP 5 PROCESSES BY MEMORY USAGE]"
ps -eo pid,comm,%cpu,%mem --sort=-%mem | head -n 6

# Stretch Goal Extras
echo ""
echo "[EXTRA INFO]"
echo "Failed login attempts (last 24h):"
journalctl -u ssh --since "24 hours ago" 2>/dev/null | grep "Failed password" | wc -l
echo "============================================================"
