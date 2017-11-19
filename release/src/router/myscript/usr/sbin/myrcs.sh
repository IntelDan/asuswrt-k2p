#!/bin/sh 

/sbin/modprobe xt_set
/sbin/modprobe ip_set_hash_net
/sbin/modprobe ip_set_hash_ip
/usr/sbin/myscript_mentohust.sh start
/usr/sbin/ssr_mon.sh &
#nvram set country_code=#a
