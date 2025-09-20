# server-stats
# Server Stats Script

A simple Bash script to analyze basic server performance stats on any Linux system.

## Features
- Total CPU usage
- Total memory usage (free vs used with percentage)
- Total disk usage (free vs used with percentage)
- Top 5 processes by CPU usage
- Top 5 processes by memory usage
- Extra info: OS version, uptime, load average, logged in users, failed login attempts (last 24h)


How to Execute

Make the script executable (only needed the first time):

chmod +x server-stats.sh


Run the script:

./server-stats.sh


(Optional) Run with bash if you don’t want to make it executable:

bash server-stats.sh
