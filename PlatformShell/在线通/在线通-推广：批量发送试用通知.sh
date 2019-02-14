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
	EnterID=`echo $line|cut -d ',' -f1`

	#以下为获取组织已经创建的天数
    create_time=`echo $line|cut -d ',' -f4`
	create_time=`date -d "$create_time" +%s`
	nowtime=`date +%s`

	reamintime=$(($nowtime-$create_time))
	day=$(($reamintime/86400))

#剩余3天
  if [ "$day" = "27" ];then
  #组织的所有成员信息
	rm -rf /var/lib/mysql-files/trialentbuddy.txt
	\cp getEntBuddy_bak.sql getEntBuddy.sql 

	sed -i "s/EnterID/$EnterID/g" getEntBuddy.sql
	mysql -u root -pwww.simba.pro simba_db1<getEntBuddy.sql


  cat /var/lib/mysql-files/trialentbuddy.txt| while read line2
  do
  user_number=`echo $line2`
  # echo $user_number
	curl -H "Content-Type:application/json" -X POST --data '{
	"bizTypeCode":"notice",
	"templateCode":"notice_general",
	"businessId":"99999",
	"subject":"到期提醒通知",
	"summary":null,
	"content":"温馨提示，试用3天后到期",
	"enterId":null,
	"enterName":null,
	"imageUrl":null,
	"attachNum":0,
	"feedbackFlag":null,
	"linkUrl":"https://app.peopleyun.cn/zxtopen/trialnotice/index27.html",
	"pointLink":"https://app.peopleyun.cn/zxtopen/trialnotice/index27.html",
	"version":null,
	"sender":10000,
	"receivers":['$user_number'],
	"form":null,
	"multiContent":null,
	"rich":null}' "http://10.0.0.11:8015/nc-server-business/nc/business/sendBusinessNotice"
  done
  fi

#剩余7天
  if [ "$day" = "23" ];then
  #组织的所有成员信息
	rm -rf /var/lib/mysql-files/trialentbuddy.txt
	\cp getEntBuddy_bak.sql getEntBuddy.sql

	sed -i "s/EnterID/$EnterID/g" getEntBuddy.sql
	mysql -u root -pwww.simba.pro simba_db1<getEntBuddy.sql


  cat /var/lib/mysql-files/trialentbuddy.txt| while read line2
  do
  user_number=`echo $line2`
  echo $user_number
	curl -H "Content-Type:application/json" -X POST --data '{
	"bizTypeCode":"notice",
	"templateCode":"notice_general",
	"businessId":"99999",
	"subject":"到期提醒通知",
	"summary":null,
	"content":"温馨提示，试用7天后到期",
	"enterId":null,
	"enterName":null,
	"imageUrl":null,
	"attachNum":0,
	"feedbackFlag":null,
	"linkUrl":"https://app.peopleyun.cn/zxtopen/trialnotice/index23.html",
	"pointLink":"https://app.peopleyun.cn/zxtopen/trialnotice/index23.html",
	"version":null,
	"sender":10000,
	"receivers":['$user_number'],
	"form":null,
	"multiContent":null,
	"rich":null}' "http://10.0.0.11:8015/nc-server-business/nc/business/sendBusinessNotice"
  done
  fi

#最后一天的提醒
  if [ "$day" = "30" ];then
  #组织的所有成员信息
	rm -rf /var/lib/mysql-files/trialentbuddy.txt
	\cp getEntBuddy_bak.sql getEntBuddy.sql

	sed -i "s/EnterID/$EnterID/g" getEntBuddy.sql
	mysql -u root -pwww.simba.pro simba_db1<getEntBuddy.sql


  cat /var/lib/mysql-files/trialentbuddy.txt| while read line2
  do
  user_number=`echo $line2`
  echo $user_number
	curl -H "Content-Type:application/json" -X POST --data '{
	"bizTypeCode":"notice",
	"templateCode":"notice_general",
	"businessId":"99999",
	"subject":"到期提醒通知",
	"summary":null,
	"content":"温馨提示：您所创建的组织，明天将解散",
	"enterId":null,
	"enterName":null,
	"imageUrl":null,
	"attachNum":0,
	"feedbackFlag":null,
	"linkUrl":"https://app.peopleyun.cn/zxtopen/trialnotice/index30.html",
	"pointLink":"https://app.peopleyun.cn/zxtopen/trialnotice/index30.html",
	"version":null,
	"sender":10000,
	"receivers":['$user_number'],
	"form":null,
	"multiContent":null,
	"rich":null}' "http://10.0.0.11:8015/nc-server-business/nc/business/sendBusinessNotice"
  done
  fi
  

done















#------------------------【发送业务通知】------------------------
curl -H "Content-Type:application/json" -X POST --data '{
"bizTypeCode":"notice",
"templateCode":"notice_general",
"businessId":"99999",
"subject":"到期提醒通知",
"summary":null,
"content":"温馨提示，您所创建的组织，明天会解散",
"enterId":null,
"enterName":null,
"imageUrl":null,
"attachNum":0,
"feedbackFlag":null,
"linkUrl":"https://app.peopleyun.cn/zxtopen/trialnotice/index27.html",
"pointLink":"https://app.peopleyun.cn/zxtopen/trialnotice/index27.html",
"version":null,
"sender":10000,
"receivers":[66557562],
"form":null,
"multiContent":null,
"rich":null}' "http://10.0.0.11:8015/nc-server-business/nc/business/sendBusinessNotice"

66521981,61000912

