#!/bin/sh
check_time=120
while [ "1" = "1" ]  
do 
  sleep $check_time

#check iptables

   icount=`ps -w|grep ssr-retcp |grep -v grep |wc -l`

   icount2=`iptables -t nat -S|grep SHADOW|wc -l`
   if [ $icount = 0 -o $icount2 -lt 5 ] ;then
   logger -t "ssr" "iptables error,restart ssr!"
   /usr/sbin/myscript_ssr.sh 
   exit 0
   fi

#check dnsproxy
   icount=`ps -w|grep dnsproxy |grep -v grep |wc -l`
   if [ $icount = 0 ] ;then
   logger -t "ssr" "dnsproxy error,restart ssr!"
   /usr/sbin/myscript_ssr.sh 
   exit 0
   fi

done

