#!/bin/sh
while read line  
do
	redis-cli -a dtsgx0591 ZCOUNT ss-offmsg_${line} 0 +inf
done < jtb.txt

