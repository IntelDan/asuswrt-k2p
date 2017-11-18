#!/bin/sh 

stop() {

#清除防火墙规则
killall -q -9 ssr_mon.sh

/usr/sbin/ssr-rules clean all

killall -q -9 ssr-redir


#icount=`ps -w |grep pdnsd|grep -v grep|wc -l`
#if [ $icount -gt 0 ] ;then	
killall -q pdnsd  
rm -f /tmp/etc/dnsmasq.user/gfw_list.conf 2>/dev/null 
rm -f /tmp/etc/dnsmasq.user/gfw_addr.conf 2>/dev/null
rm -f /tmp/etc/dnsmasq.user/gfw_user.conf 2>/dev/null
/sbin/restart_dns 2>/dev/null
#fi

}

start() {
#不重复启动
icount=`ps -w|grep ssr-redir|grep -v grep|wc -l`

if [ $icount = 0 ] ;then

sindex=`nvram get ssr_index`

mcmd="echo \"`nvram get ssr_server_ip`\"|awk -F '>' '{printf \$$sindex}'"
mip=`echo $mcmd |sh`

mcmd="echo \"`nvram get ssr_server_port`\"|awk -F '>' '{printf \$$sindex}'"
mport=`echo $mcmd |sh`

mcmd="echo \"`nvram get ssr_server_timeout`\"|awk -F '>' '{printf \$$sindex}'"
mtimeout=`echo $mcmd |sh`

mcmd="echo \"`nvram get ssr_server_passwd`\"|awk -F '>' '{printf \$$sindex}'"
mpasswd=`echo $mcmd |sh`

mcmd="echo \"`nvram get ssr_server_encrypt`\"|awk -F '>' '{printf \$$sindex}'"
mencrypt=`echo $mcmd |sh`

mcmd="echo \"`nvram get ssr_server_protocol`\"|awk -F '>' '{printf \$$sindex}'"
mprotocol=`echo $mcmd |sh`

mcmd="echo \"`nvram get ssr_server_obfs`\"|awk -F '>' '{printf \$$sindex}'"
mobfs=`echo $mcmd |sh`

mcmd="echo \"`nvram get ssr_server_obfspara`\"|awk -F '>' '{printf \$$sindex}'"
mobfspara=`echo $mcmd |sh`


#产生配置文件
		cat <<-EOF >/tmp/shadowsocksr.json
		{
		    
		    "server": "$mip",
		    "server_port": $mport,
		    "local_address": "0.0.0.0",
		    "local_port": 1234,
		    "password": "$mpasswd",
		    "timeout": $mtimeout,
		    "method": "$mencrypt",
		    "protocol": "$mprotocol",
		    "obfs": "$mobfs",
		    "obfs_param": "$mobfspara",
		    "fast_open": false
		}
EOF


/usr/sbin/ssr-redir  -c /tmp/shadowsocksr.json -f /tmp/ssr-retcp.pid
/usr/sbin/ssr-rules  $mip  1234 &

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

restart
