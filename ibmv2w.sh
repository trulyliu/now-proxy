#!/bin/sh
read -p "请输入应用程序名称:" appname
read -p "请设置你的容器内存大小(默认256):" ramsize
read -p "请输入shadowsocks密码:" mypass
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
echo -n $mypass  > mypass
ibmcloud target --cf
ibmcloud cf push
ibmyuming=$(ibmcloud app show $appname | grep routes |awk '{print $2}')
    VMESSCODE=$(base64 -w 0 << EOF
    {
      "v": "2",
      "ps": "ibm-cf",
      "add": "$ibmyuming",
      "port": "443",
      "id": "535510a7-8b81-4c8d-aa59-8c890acc037c",
      "aid": "4",
      "net": "ws",
      "type": "none",
      "host": "",
      "path": "/v2vmess",
      "tls": "tls"
    }
EOF
    )
	echo "配置链接："
    echo vmess://${VMESSCODE}
