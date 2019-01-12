#!/bin/bash

Install_BBR(){
	wget -N --no-check-certificate "https://raw.githubusercontent.com/chiakge/Linux-NetSpeed/master/tcp.sh"
chmod +x tcp.sh
./tcp.sh
}

GET_SERVER_IP(){
	if [ ! -f /root/.ip.txt ];then
		curl -s 'https://myip.ipip.net' > /root/.ip.txt
		Number_of_file_characters=`cat .ip.txt | wc -L`
		if [ ${Number_of_file_characters} -gt '100' ];then
			curl -s 'http://ip.cn' > /root/.ip.txt
		fi
	fi
	SERVER_IP_INFO=`sed -n '1p' /root/.ip.txt`
}

INSTALL(){
	if [ ! -f /usr/bin/ssr ];then
		wget -O /root/ssr_file.zip "https://github.com/qinghuas/ss-panel-and-ss-py-mu/archive/master.zip"
		unzip /root/ssr_file.zip -d /root;mv /root/ss-panel-and-ss-py-mu-master/* /root
		cp /root/ssr.sh /usr/bin/ssr;chmod 777 /usr/bin/ssr
		rm -rf ssr_file.zip /root/ss-panel-and-ss-py-mu-master /root/picture /root/README.md /root/ssr.sh
		clear;echo "INSTALL DONE,Hellow.";sleep 1
	fi
}

UPDATE_SHADOWSOCKS_COMMAND(){
	if [ -f /usr/bin/shadowsocks ];then
		wget -O /usr/bin/shadowsocks "https://raw.githubusercontent.com/qinghuas/ss-panel-and-ss-py-mu/master/node/ss"
		chmod 777 /usr/bin/shadowsocks
	fi
}

UNINSTALL(){
	rm -rf /usr/bin/ssr /root/tools /root/node /root/.ip.txt
	clear;echo "UNINSTALL DONE,Bye."
}

REINSTALL(){
	UNINSTALL
	INSTALL
	UPDATE_SHADOWSOCKS_COMMAND
	clear;echo "REINSTALL DONE,Meet Again."
}

GET_NODE_SH_FILE(){
	if [ ! -f /root/node.sh ];then
		wget "https://dl.52ll.org/node.sh";chmod 777 node.sh
	else
		echo "node.sh 已存在."
	fi
}

INSTALL
GET_SERVER_IP

echo "####################################################################
# 个人定制版                                                       #
####################################################################
# [1] [安装BBR合集版]                                              #
# [2] [待定.]                                                      #
####################################################################
# [x]重新加载 [y]更新脚本 [z]删除脚本 [about]关于脚本              #
# ${SERVER_IP_INFO}
####################################################################"
read -p "PLEASE SELECT OPTIONS:" SSR_OPTIONS

clear;case "${SSR_OPTIONS}" in
	1)
	Install_BBR;;
	x)
	/usr/bin/ssr;;
	y)
	REINSTALL;;
	z)
	UNINSTALL;;
	about)
	cat /root/tools/about.txt;;
	node)
	GET_NODE_SH_FILE;;
	*)
	echo "选项不在范围内,2s后将重新加载,请注意选择...";sleep 2
	/usr/bin/ssr;;
esac

#END 2018-01-02 13:24
