#!/bin/sh

if [ ! -d /jffs/mentohust ]
then
mkdir /jffs/mentohust
fi

enabled=nvram get mentohust_en
if [ enabled = "1" ]
then
logger "mentohust start..."
/jffs/mentohust/mentohust -b3 -y0
fi