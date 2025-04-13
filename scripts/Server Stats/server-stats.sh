#!/bin/bash

echo "--------------------------------------------------"
echo "🖥️  SERVER PERFORMANCE STATS"
echo "Generated on: $(date)"
echo "--------------------------------------------------"


echo -e "\n📦 OS Version:"
cat /etc/os-release | grep PRETTY_NAME | cut -d= -f2


echo -e "\n⏱️ Uptime:"
uptime -p


echo -e "\n📊 Load Average:"
uptime | awk -F 'load average: ' '{ print $2 }'


echo -e "\n👤 Logged In Users:"
who | wc -l


echo -e "\n🔐 Failed Login Attempts (last 24h):"
journalctl _COMM=sshd --since "1 day ago" | grep "Failed password" | awk '{ print "User: "  $(NF -5), "   from IP: " $(NF - 3) }'


echo -e "\n🧠 Total CPU Usage:"
top -bn1 | grep '%Cpu(s)' | \
awk '{ print "Used: " $2 + $4 "% | idle: " $8 "%" }'


echo -e "\n💾 Memory Usage:"
free -h | awk 'NR==2{printf "Used: %s / %s (%.2f%%)\n", $3, $2, ($3/$2)*100}'


echo -e "\n🗄️ Disk Usage (Root Partition):"
df -h / | awk 'NR==2{printf "Used: %s / %s (%s)\n", $3, $2, $5}'


echo -e "\n🔥 Top 5 Processes by CPU Usage:"
ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6


echo -e "\n💽 Top 5 Processes by Memory Usage:"
ps -eo pid,comm,%mem --sort=-%mem | head -n 6

echo "--------------------------------------------------"