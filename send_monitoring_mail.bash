#!/bin/bash

# Mail related
email=""

# IP addr
URL="https://ifconfig.me"
ip_addr=$(curl -s $URL)

# Ram usage
ram_total=$(cat /proc/meminfo | grep MemTotal)
ram_available=$(cat /proc/meminfo | grep MemAvailable)
ram="$ram_total\n$ram_available\n"

# CPU temperature
cpu_temp=$(sudo sensors)

# Disk temperature
disks=("/dev/sda","/dev/sdb")
for i in "/dev/sda" "/dev/sdb"
do
	disk_temp=""$disk_temp"$(sudo hddtemp "$i")\n"
done

response="Server System Report\n$(date)\n\n"
response="$response===Current IP:===\nIP: $ip_addr\n============\n\n"
response="$response===Current Ram Usage:===\n$ram============\n\n"
response="$response===Current CPU Temperature:===\n$cpu_temp\n============\n\n"
response="$response===Current Disk Temperature:===\n$disk_temp============\n\n"
response="$response\nBest Regards,\nAdministrator\n"

printf "$response"

printf "$response" | /usr/sbin/ssmtp "$email"

