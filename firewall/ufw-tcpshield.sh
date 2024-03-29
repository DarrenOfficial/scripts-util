#!/bin/sh

echo "Adding allow in from TCPShield IPv4 & IPv6"
curl -s https://tcpshield.com/v4/ -o /tmp/tcp_ips

# Allow all traffic from TCPShield IP (no ports restriction)
for tcip in `cat /tmp/tcp_ips`; do ufw allow proto tcp from $tcip comment 'TCPSheild IP'; done

ufw reload > /dev/null
