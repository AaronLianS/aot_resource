#!/bin/sh
timeStamp=`date -d "2 days ago" +%s`      #将current转换为时间戳，精确到秒
currentTimeStamp=$((timeStamp*1000000+`date "+%N"`/1000000000)) #将current转换为时间戳，精确到microseconds

while read line  
do
	redis-cli -a dtsgx0591 ZREMRANGEBYSCORE ss-offmsg_${line} 0 $currentTimeStamp
done < jtb.txt

