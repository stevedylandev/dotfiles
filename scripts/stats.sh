#!/usr/bin/env bash
# basic stats checker script mostly adapted from statusbar, may need changes to work on your system

CPU_TEMP=$(sensors | awk '
    /^Tdie|^Tctl|^Package id|^Core 0|^CPU|^temp1/ {
        gsub(/[+°C]/, "");
        for (i=1; i<=NF; i++) {
            if ($i ~ /^[0-9]+(\.[0-9]+)?$/) {
                gsub(/\..*/, "", $i);
                print $i;
                exit;
            }
        }
    }')

MEM_USE=$(free -m | awk '/^Mem/ {print ($3)/1024}'| cut -c-4)
CPU_USE=$(iostat -c | awk 'NR>=4 && NR <=4' | awk '{print "User CPU: "$1"%\nSystem CPU: ",$3"%"}')
GPU_TEMP=$(sensors | awk '/^edge/ {print substr($2,2)}')


DISK1=$(df -h ~/ | awk 'NR==2 {print $4}')
DISK2=$(df -h / | awk 'NR==2 {print $4}')

# [[ -n $(amixer get Capture | awk '/\[on\]/') ]] && MIC="on" || MIC="off"
UPDATE=$(stat -c %y /lib/apk/db/installed | awk '{print $1}')
KERNEL=$(uname -r)

echo -e "Stats $CPU_USE

GPU temp: $GPU_TEMP
CPU temp: $CPU_TEMP°C

Memory use: ${MEM_USE}g

Home remaining: $DISK1
Root remaining: $DISK2

Last update: $UPDATE       $KERNEL" \
| bat -l cpuinfo --style=grid

