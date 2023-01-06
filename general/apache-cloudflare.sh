#!/bin/bash
# Simple bash script to restore visitor real IP under Cloudflare with Nginx

CURL_BIN=$(command -v curl)
CF_IPV4=$($CURL_BIN -sL https://www.cloudflare.com/ips-v4)
CF_IPV6=$($CURL_BIN -sL https://www.cloudflare.com/ips-v6)

echo '' > /etc/apache2/conf-enabled/remoteip.conf
echo "####################################"
echo "Adding Cloudflare IPv4"
echo "####################################"
for cf_ip4 in $CF_IPV4; do
    echo "RemoteIPTrustedProxy $cf_ip4;" >> /etc/apache2/conf-enabled/remoteip.conf
done
echo "####################################"
echo "Adding Cloudflare IPv6"
echo "####################################"
for cf_ip6 in $CF_IPV6; do
    echo "RemoteIPTrustedProxy $cf_ip6;" >> /etc/apache2/conf-enabled/remoteip.conf
done
echo 'RemoteIPHeader CF-Connecting-IP;' >> /etc/apache2/conf-enabled/remoteip.conf

systemctl restart apache2
