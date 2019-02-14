#!/bin/bash
#开始获取试用的组织架构
EntInfo=`cat Entinfo.txt`
EntInfo=`echo ${EntInfo%,*}`

\cp getEntInfo_bak.sql getEntInfo.sql
sed -i "s/seduic_enterprise_info/$EntInfo/g" getEntInfo.sql

rm -rf /var/lib/mysql-files/trialent.txt
mysql -u root -pwww.simba.pro simba_db1<getEntInfo.sql
# select concat(id,',',enter_name,',',user_number,',',FROM_UNIXTIME(create_time,'%Y%m%d')) into outfile '/var/lib/mysql-files/trialent.txt' from uic_enterprise_info where id in (235843);
# exit; 

cat /var/lib/mysql-files/trialent.txt| while read line
do
#获取组织基础数据
	enterpriseId=`echo $line|cut -d ',' -f1`
	userNumber=`echo $line|cut -d ',' -f3`
	enterpriseName=`echo $line|cut -d ',' -f2`
	#以下为获取组织已经创建的天数
    create_time=`echo $line|cut -d ',' -f4`
	create_time=`date -d "$create_time" +%s`
	nowtime=`date +%s`

	reamintime=$(($nowtime-$create_time))
	day=$(($reamintime/86400))
# enterpriseId=700110
	# userNumber=61009654
	# enterpriseName=测试组织安安
	
#解散组织
  if [ "$day" = "31" ];then

curl -X GET -G --data-urlencode "enterpriseName=$enterpriseName" "http://base1.zxt.pro:8015/uic-server-enterprise/uic/enterprise/dissolve?enterpriseId=$enterpriseId&userNumber=$userNumber"
sed -i "s/$enterpriseId,//g" Entinfo.txt
sed -i "s/$enterpriseId//g" Entinfo.txt
  fi

done


