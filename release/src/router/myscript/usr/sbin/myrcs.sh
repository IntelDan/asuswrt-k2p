#!/bin/sh 

/sbin/modprobe xt_set
/sbin/modprobe ip_set
/sbin/modprobe ip_set_hash_net
/sbin/modprobe ip_set_hash_ip
/usr/sbin/myscript_setname.sh
/usr/sbin/myscript_ssr.sh
/usr/sbin/myscript_mentohust.sh
#nvram set country_code=#a
