#!/bin/bash
#title         	:openvpnhosts.sh
#description   	:OpenVPN DNS lookups by using /etc/hosts
#author			:Franesco d'Aloisio - fdaloiso@gmail.com
#site			:https://github.com/fradaloisio/openvpnhosts
#date         	:2016-12-02
#version     	:0.1

LOGFILE=/var/log/openvpnhosts.log

tail -f -n0 /var/log/openvpn.log | grep --line-buffered "MULTI_sva: pool returned IPv4=" | while read line;do
	PROF=$(echo $line | grep "MULTI_sva: pool returned IPv4=" | awk '{print$6}' | awk -F"/" '{print$1}')
	IP=$(echo $line | grep "MULTI_sva: pool returned IPv4=" | awk '{print$10}' | sed 's/IPv4=//' | sed 's/,//')
	echo "FOUND $IP $PROF"
	grep $PROF /etc/hosts | while read -r H;do
		O_IP=$(echo $H | cut -d" " -f1)
		O_PROF=$(echo $H | cut -d" " -f2)
		
		echo "[`date +%Y-%m-%dT%H:%M:%S`] [DEL] IPv4=$O_IP Profile=$O_PROF" >> $LOGFILE
		sed -i "/^$O_IP $O_PROF$/d" /etc/hosts 
	done

	grep $IP /etc/hosts | while read -r H;do
		O_IP=$(echo $H | cut -d" " -f1)
		O_PROF=$(echo $H | cut -d" " -f2)
		
		echo "[`date +%Y-%m-%dT%H:%M:%S`] [DEL] IPv4=$O_IP Profile=$O_PROF" >> $LOGFILE
		sed -i "/^$O_IP $O_PROF$/d" /etc/hosts 
	done
	echo $IP $PROF >> /etc/hosts
	echo "[`date +%Y-%m-%dT%H:%M:%S`] [ADD] IPv4=$IP Profile=$PROF" >> $LOGFILE
done

