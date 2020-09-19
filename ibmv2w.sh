#!/bin/sh
read -p "请输入应用程序名称:" appname
read -p "请设置你的容器内存大小(默认256):" ramsize
if [ -z "$ramsize" ];then
	ramsize=256
fi
rm -rf phpcf
mkdir phpcf
cd phpcf
echo '<!DOCTYPE html> '>>index.php
echo '<html> '>>index.php
echo '<body>'>>index.php
echo '<?php '>>index.php
echo 'echo "Hello World!"; '>>index.php
echo '?> '>>index.php
echo '<body>'>>index.php
echo '</html>'>>index.php
wget https://raw.githubusercontent.com/trulyliu/now-proxy/master/entrypoint.sh
chmod +x entrypoint.sh
echo 'applications:'>>manifest.yml
echo '- path: .'>>manifest.yml
echo '  command: '/app/htdocs/entrypoint.sh'' >>manifest.yml
echo '  name: '$appname''>>manifest.yml
echo '  random-route: true'>>manifest.yml
echo '  memory: '$ramsize'M'>>manifest.yml
ibmcloud target --cf
ibmcloud cf push
ibmyuming=$(ibmcloud app show $appname | grep routes |awk '{print $2}')
    VMESSCODE=$(base64 -w 0 << EOF
    {
      "v": "2",
      "ps": "v2ws IBM",
      "add": "$ibmyuming",
      "port": "443",
      "id": "aae6bb78-d50b-4f0e-888e-74896a2a56a3",
      "aid": "4",
      "net": "ws",
      "type": "none",
      "host": "",
      "path": "/ws-vmess",
      "tls": "tls"
    }
EOF
    )
	echo "配置链接："
    echo vmess://${VMESSCODE}
