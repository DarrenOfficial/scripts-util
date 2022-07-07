#!/bin/bash
# Simple bash script to restore visitor real IP under Cloudflare with Nginx

CURL_BIN=$(command -v curl)
CF_IPV4=$($CURL_BIN -sL https://www.cloudflare.com/ips-v4)
CF_IPV6=$($CURL_BIN -sL https://www.cloudflare.com/ips-v6)

echo '' > /www/server/panel/vhost/nginx/cloudflare.conf
echo "####################################"
echo "Adding Cloudflare IPv4"
echo "####################################"
for cf_ip4 in $CF_IPV4; do
    echo "set_real_ip_from $cf_ip4;" >> /www/server/panel/vhost/nginx/cloudflare.conf
done
echo "####################################"
echo "Adding Cloudflare IPv6"
echo "####################################"
for cf_ip6 in $CF_IPV6; do
    echo "set_real_ip_from $cf_ip6;" >> /www/server/panel/vhost/nginx/cloudflare.conf
done
echo 'real_ip_header CF-Connecting-IP;' >> /www/server/panel/vhost/nginx/cloudflare.conf

nginx -t && systemctl reload nginx
