#!/bin/sh
check_time=120
enabled=$(nvram get mentohust_enabled)
if [ "$enabled" != "1" ]
then
	exit 0
fi
#start daemon
while [ "1" = "1" ]  
do 
  sleep $check_time
#check mentohust

   icount=`ps -w | grep "mentohust -b3" | grep -v grep |wc -l`

   if [ $icount = 0 ] ;then
   logger -t "mentohust" "mentohust error,restart mentohust!"
   /usr/sbin/myscript_mentohust.sh restart
   exit 0
   fi

done
