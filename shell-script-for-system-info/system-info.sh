#!/bin/bash

set -euo pipefail

echo "--- System Information ---"

echo "User: $(whoami)"

echo "Date: $(date)"

echo "Hostname: $(hostname)"


if [ -f "/etc/os-release" ]; then
    . /etc/os-release
    echo "OS version: ${PRETTY_NAME:-'Not found'}" 
else
    echo "OS version: /etc/os-release not found." >&2  
fi


cpu_info=$(lscpu 2>/dev/null | awk -F': +' '/Model name/ {print $2}')
if [ -n "$cpu_info" ]; then 
    echo "CPU Info: $cpu_info"
else
    echo "CPU Info: Could not retrieve CPU model name." >&2
fi

memory_info=$(free -h 2>/dev/null | awk '/^Mem:/ {print $2}')

if [ -n "$memory_info" ]; then
    echo "Memory Info: $memory_info"
else
    echo "Memory Info: Could not retrieve total memory info." >&2
fi
