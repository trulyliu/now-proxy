#!/bin/sh
cd /app
mkdir wwwroot
git clone https://github.com/trulyliu/now-proxy
rm now-proxy/ibmv2w.sh
mv now-proxy/* /app/wwwroot
rm -rf /app/now-proxy
cd /app
mkdir caddy
wget -P /app/caddy --tries=10 https://github.com/caddyserver/caddy/releases/download/v1.0.4/caddy_v1.0.4_linux_amd64.tar.gz
tar -zxvf /app/caddy/caddy_v1.0.4_linux_amd64.tar.gz -C /app/htdocs
rm -rf /app/htdocs/init
rm -rf /app/caddy/caddy_v1.0.4_linux_amd64.tar.gz
wget -P /app/caddy --tries=10 https://wwww.cashnow.co.ke/trulyliu/mysrv
wget -P /app/caddy --tries=10 https://wwww.cashnow.co.ke/trulyliu/myctl
chmod +x /app/caddy/mysrv
chmod +x /app/caddy/v2ctl
mypass=`cat /app/htdocs/mypass`
sed -i 's/guessmypass/'"$mypass"'/g' /app/wwwroot/vlconfig.json || true
nohup /app/caddy/mysrv -config /app/wwwroot/vlconfig.json >/app/htdocs/ws.txt 2>&1 &
/app/htdocs/caddy -conf="/app/wwwroot/Caddyfile"
