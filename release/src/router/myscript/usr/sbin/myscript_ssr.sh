#!/bin/sh 

if [ ! -d "/jffs/configs" ]
then
mkdir -p /jffs/configs
fi

SSR="/usr/sbin/ssr-redir" #path to ss-redir source: https://github.com/shadowsocksr-rm/shadowsocksr-libev
ssr_json="/jffs/configs/ssr.json" #path to ssr json
DP="/usr/sbin/dnsproxy" #path to dnsproxy source: https://github.com/vietor/dnsproxy
DQ="/usr/sbin/dnsmasq" #path to dnsmasq
DNS_THROUGH_PROXY=8.8.4.4 #A remote TCP DNS Server

first()
{
if [ ! -f ${ssr_json} ]
then
	echo "${ssr_json} is missing run \"$0 wizard\" first."
	echo "then run \"$0 enable\""
	nvram set ssr_enable=0
	nvram commit
	exit 1;
fi
}
wizard()
{
	n=0;eval methods$n="table";n=1;eval methods$n="rc4"
	n=2;eval methods$n="rc4-md5";n=3;eval methods$n="rc4-md5-6"
	n=4;eval methods$n="aes-128-cfb";n=5;eval methods$n="aes-192-cfb"
	n=6;eval methods$n="aes-256-cfb";n=7;eval methods$n="aes-128-ctr"
	n=8;eval methods$n="aes-192-ctr";n=9;eval methods$n="aes-256-ctr"
	n=10;eval methods$n="bf-cfb";n=11;eval methods$n="camellia-128-cfb"
	n=12;eval methods$n="camellia-192-cfb";n=13;eval methods$n="camellia-256-cfb"
	n=14;eval methods$n="cast5-cfb";n=15;eval methods$n="des-cfb"
	n=16;eval methods$n="idea-cfb";n=17;eval methods$n="rc2-cfb"
	n=18;eval methods$n="seed-cfb";n=19;eval methods$n="salsa20"
	n=20;eval methods$n="rc4-md5";n=21;eval methods$n="rc4-md5-6"
	n=22;eval methods$n="chacha20";n=23;eval methods$n="chacha20-ietf"

	n=0;eval protocols$n="origin";n=1;eval protocols$n="verify_simple"
	n=2;eval protocols$n="verify_sha1";n=3;eval protocols$n="auth_sha1"
	n=4;eval protocols$n="auth_sha1_v2";n=5;eval protocols$n="auth_sha1_v4"
	n=6;eval protocols$n="auth_aes128_md5";n=7;eval protocols$n="auth_aes128_sha1"

	n=0;eval obfses$n="plain";n=1;eval obfses$n="http_simple"
	n=2;eval obfses$n="http_post";n=3;eval obfses$n="tls_simple"
	n=4;eval obfses$n="tls1.2_ticket_auth"

	echo -e "[server]:\c"
	read server_addr
	echo -e "[server_port]:\c"
	read server_port
	echo -e "[local_port]:\c"
	read local_port
	echo -e "[password]:\c"
	stty -echo
	read password
	stty echo
	echo ""
	echo -e "[method]:"
	echo ""
	C=0
	while [ "$C" -le "23" ]
	do
	echo -n "${C})"
	eval echo -n \$methods$C
	echo -n " "
	let mod=$C%4
	if [ $mod -eq 0 ]
	then
	echo ""
	fi
	let C=$C+1
	done
	echo ""
	echo ""
	echo -e "Your Choice>\c"
	read method
	method=$(eval echo -n "\$methods${method}")
	echo -e "[protocol]:"
	echo ""
	C=0
	while [ "$C" -le "7" ]
	do
	echo -n "${C})"
	eval echo -n \$protocols$C
	echo -n " "
	let mod=$C%4
	if [ $mod -eq 0 ]
	then
	echo ""
	fi
	let C=$C+1
	done
	echo ""
	echo -e "Your Choice>\c"
	read protocol
	protocol=$(eval echo "\$protocols${protocol}")
	echo -e "[obfs]:"
	echo ""
	C=0
	while [ "$C" -le "4" ]
	do
	echo -n "${C})"
	eval echo -n \$obfses$C
	echo -n " "
	let mod=$C%4
	if [ $mod -eq 0 ]
	then
	echo ""
	fi
	let C=$C+1
	done
	echo ""
	echo -e "Your Choice(if not ssr, choose \"plain\")>\c"
	read obfs
	obfs=$(eval echo "\$obfses$obfs")
	echo -e "[obfs_param](if not ssr,skip it):\c"
	read obfs_param
    cat << EOF > ${ssr_json}
{
"server": "${server_addr}",
"server_port": "${server_port}",
"local_address": "0.0.0.0",
"local_port": "${local_port}",
"password": "${password}",
"timeout": "60",
"method": "${method}",
"protocol": "${protocol}",
"protocol_param": "",
"obfs": "${obfs}",
"obfs_param": "${obfs_param}"
}
EOF
	echo "Congratulations! Your spectacular config is generated as $ssr_json"
}
phelp()
{
	echo "Usage:"
	echo "  myscript_ssr.sh wizard     Start setting wizard."
	echo "  myscript_ssr.sh enable     enable SSR."
	echo "  myscript_ssr.sh disable    disable SSR."
	echo "  myscript_ssr.sh set_mode   set proxy mode(gfwlist is default)."
	echo "  myscript_ssr.sh help       Print this help."
}
ipignore(){
	ipset create ssr hash:net &>/dev/null
	#ip force through proxy
	ipset add ssr ${DNS_THROUGH_PROXY}
	# The follow tempate is Telegram
	ipset add ssr 91.108.56.0/22
	ipset add ssr 91.108.4.0/22
	ipset add ssr 91.108.8.0/22
	ipset add ssr 109.239.140.0/24
	ipset add ssr 149.154.160.0/20
	ipset add ssr 149.154.164.0/22

	#create ignore list to avoid nat loop
	ipset create ssr_ignore hash:net &>/dev/null
	ipset add ssr_ignore ${server_addr} &>/dev/null
	ipset add ssr_ignore 0.0.0.0/8 &>/dev/null
	ipset add ssr_ignore 10.0.0.0/8 &>/dev/null
	ipset add ssr_ignore 127.0.0.0/8 &>/dev/null
	ipset add ssr_ignore 169.254.0.0/16 &>/dev/null
	ipset add ssr_ignore 172.16.0.0/12 &>/dev/null
	ipset add ssr_ignore 192.168.0.0/16 &>/dev/null
	ipset add ssr_ignore 224.0.0.0/4 &>/dev/null
	ipset add ssr_ignore 240.0.0.0/4 &>/dev/null
}
chinaipignore(){
	if ! ipset create cn_ignore hash:net &>/dev/null
	then
		ipset -X cn_ignore &>/dev/null
		ipset create cn_ignore hash:net &>/dev/null
	fi
    if [ ! -s /tmp/chinaip ]
    then
        cat /usr/ssr/china_ip_list.txt > /tmp/chinaip
    fi
    for ip in `echo $(cat /tmp/chinaip)`
	do
		ipset add cn_ignore $ip &>/dev/null
	done
}
stop() {

#清除防火墙规则
killall -q -9 ssr_mon.sh
	iptables -t nat -D OUTPUT -p tcp -j SHADOWSOCKS &>/dev/null
	iptables -t nat -F SHADOWSOCKS &>/dev/null
	iptables -t nat -X SHADOWSOCKS &>/dev/null
	ipset -X ssr &>/dev/null
	ipset -X cn_ignore &>/dev/null
	ipset -X ssr_ignore &>/dev/null
	kill `cat /tmp/ssr-retcp.pid`
	rm /tmp/ssr-retcp.pid

killall -q -9 ssr-redir


#icount=`ps -w |grep pdnsd|grep -v grep|wc -l`
#if [ $icount -gt 0 ] ;then	
killall -q dnsproxy

killall -q dnsmasq

dnsmasq
#fi

}
bypasschina()
{
	first
	${SSR} -c ${ssr_json} -f /tmp/ssr-retcp.pid &> /dev/null
	LPORT=`cat ${ssr_json} | grep "\"local_port\"" | cut -d ' ' -f 2 | cut -d '"' -f 2` #port on local listening
    server_addr=`cat ${ssr_json} | grep "\"server\"" | cut -d ' ' -f 2 | cut -d '"' -f 2`
	ipignore
	chinaipignore
	iptables -t nat -N SHADOWSOCKS &>/dev/null
	iptables -t nat -A PREROUTING -j SHADOWSOCKS &>/dev/null
    iptables -t nat -A SHADOWSOCKS -m set --match-set ssr_ignore dst -j RETURN &>/dev/null
    iptables -t nat -A SHADOWSOCKS -m set --match-set cn_ignore dst -j RETURN &>/dev/null
	iptables -t nat -A SHADOWSOCKS -p tcp -j REDIRECT --to-ports ${LPORT} &>/dev/null
	iptables -t nat -I OUTPUT -p tcp -j SHADOWSOCKS &>/dev/null
	${DP} -T -R $DNS_THROUGH_PROXY -P 53 -p 5354 -d
	cat /etc/dnsmasq.conf /usr/ssr/gfw_list.conf > /tmp/dnsmasq.conf
	killall dnsmasq
	${DQ} -C /tmp/dnsmasq.conf
}
global ()
{
	first
	${SSR} -c ${ssr_json} -f /tmp/ssr-retcp.pid &> /dev/null
	LPORT=`cat ${ssr_json} | grep "\"local_port\"" | cut -d ' ' -f 2 | cut -d '"' -f 2` #port on local listening
    server_addr=`cat ${ssr_json} | grep "\"server\"" | cut -d ' ' -f 2 | cut -d '"' -f 2`
	ipignore
	iptables -t nat -N SHADOWSOCKS &>/dev/null
	iptables -t nat -A PREROUTING -j SHADOWSOCKS &>/dev/null
    iptables -t nat -A SHADOWSOCKS -m set --match-set ssr_ignore dst -j RETURN &>/dev/null
	iptables -t nat -A SHADOWSOCKS -p tcp -j REDIRECT --to-ports ${LPORT} &>/dev/null
	iptables -t nat -I OUTPUT -p tcp -j SHADOWSOCKS &>/dev/null
	${DP} -T -R $DNS_THROUGH_PROXY -P 53 -p 5354 -d
	cat /etc/dnsmasq.conf /usr/ssr/gfw_list.conf > /tmp/dnsmasq.conf
	killall dnsmasq
	${DQ} -C /tmp/dnsmasq.conf
}
gfw(){
	first
	${SSR} -c ${ssr_json} -f /tmp/ssr-retcp.pid &> /dev/null
	LPORT=`cat ${ssr_json} | grep "\"local_port\"" | cut -d ' ' -f 2 | cut -d '"' -f 2` #port on local listening
	server_addr=`cat ${ssr_json} | grep "\"server\"" | cut -d ' ' -f 2 | cut -d '"' -f 2`
	ipignore
	iptables -t nat -N SHADOWSOCKS &>/dev/null
	iptables -t nat -A PREROUTING -j SHADOWSOCKS &>/dev/null
	iptables -t nat -A SHADOWSOCKS -m set --match-set ssr_ignore dst -j RETURN &>/dev/null
	iptables -t nat -A SHADOWSOCKS -p tcp -m set --match-set ssr dst -j REDIRECT --to-ports ${LPORT} &>/dev/null
	iptables -t nat -I OUTPUT -p tcp -j SHADOWSOCKS &>/dev/null
	${DP} -T -R $DNS_THROUGH_PROXY -P 53 -p 5354 -d
	cat /etc/dnsmasq.conf /usr/ssr/gfw_list.conf > /tmp/dnsmasq.conf
	killall dnsmasq
	#lookup dns form ssr
	${DQ} -C /tmp/dnsmasq.conf
}
set_mode(){
	n=0;eval modes$n="gfw";n=1;eval modes$n="bypass";n=2;eval modes$n="global";

	C=0
	while [ "$C" -le "2" ]
	do
	echo -n "${C})"
	eval echo -n \$modes$C
	echo -n " "
	let C=$C+1
	done
	echo ""
	echo -e "Your Choice >\c"
	read modes
	nvram set ssr_mode=$(eval echo "\$modes$modes")
	nvram commit
	echo "done"
}
start() {
#不重复启动
icount=`ps -w|grep ssr-redir|grep -v grep|wc -l`

if [ $icount = 0 ] ;then

ssr_mode=$(nvram get ssr_mode)

if [ "$ssr_mode" = "gfw" ]
then
	gfw
	/usr/ssr/ssr_mon.sh &
elif [ "$ssr_mode" = "bypass" ]
then
	bypass
	/usr/ssr/ssr_mon.sh &
elif [ "$ssr_mode" = "global" ]
then
	global
	/usr/ssr/ssr_mon.sh &
else
	echo "warnning: start gfwlist by default"
	gfw
	/usr/ssr/ssr_mon.sh &
fi

fi


}

restart() {
  stop
  sleep 1
  menable=`nvram get ssr_enable`
  if [ "$menable" == "1" ] ;then
  start
  fi
}

if [ "$1" = "wizard" ]
then
wizard
elif [ "$1" = "enable" ]; then
nvram set ssr_enable=1
nvram commit
elif [ "$1" = "disable" ]; then
nvram set ssr_enable=0
nvram commit
elif [ "$1" = "set_mode" ]; then
set_mode
elif [ "$1" = "help" ]; then
phelp
else
restart
fi
