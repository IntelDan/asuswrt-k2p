#!/bin/sh

if [ ! -d /jffs/mentohust ]
then
mkdir /jffs/mentohust
fi

start()
{
	if [ ! -f /jffs/mentohust/mentohust.conf ]
	then
		echo "run \"mentohust\" to generate /jffs/mentohust/mentohust.conf first!"
		echo "then run \"myscript_mentohust.sh enable\""
		exit 1
	fi
	enabled=$(nvram get mentohust_enabled)
	if [ "$enabled" = "1" ]
	then
		logger "mentohust start..."
		mentohust -b3 -y0
	fi
}

stop()
{
	logger "mentohust stoped"
	mentohust -k
}

if [ "$1" = "enable" ]
then
nvram set mentohust_enabled=1
nvram commit
start
echo "enabled"
elif [ "$1" = "disable" ]
then
echo "disabled"
nvram set mentohust_enabled=0
nvram commit
stop
elif [ "$1" = "start" ]
then
start
echo "started"
elif [ "$1" = "stop" ]
then
stop
echo "stoped"
fi
