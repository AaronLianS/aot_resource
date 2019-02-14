#!/bin/bash

cd /root/trial

NewUserRecord=NewUserRecord_`date -d today +"%Y%m%d"`.txt


#获取今天新注册的成员
rm -rf /var/lib/mysql-files/NewUser.txt
mysql -u root -pwww.simba.pro simba_db1<getNewUser.sql

#echo '66557562,1234,
#66598886,1234,
#66521981,1256,'>/var/lib/mysql-files/NewUser.txt
# userNumber=66557562

#开始读记录
cat /var/lib/mysql-files/NewUser.txt| while read line
do 
	userNumber=`echo $line|cut -d ',' -f1`
	userName=`echo $line|cut -d ',' -f2`
	#检查是否已经发送也新用户的注册通知，如果为空，那么则发送业务通知
	getUserRecord=`cat ./Result/$NewUserRecord|grep $userNumber`
	if [ "$getUserRecord" = "" ];then
	
	#开始发送推送
	curl -H "Content-Type:application/json" -X POST --data '{
	"bizTypeCode":"notice",
	"templateCode":"notice_general",
	"businessId":"99997",
	"subject":"欢迎使用在线通",
	"summary":null,
	"content":"欢迎使用在线通政务协作云平台！",
	"enterId":null,
	"enterName":null,
	"imageUrl":null,
	"attachNum":0,
	"feedbackFlag":null,
	"linkUrl":"https://app.peopleyun.cn/zxtopen/trialnotice/NewUserNotice.html",
	"pointLink":"https://app.peopleyun.cn/zxtopen/trialnotice/NewUserNotice.html",
	"version":null,
	"sender":10000,
	"receivers":['$userNumber'],
	"form":null,
	"multiContent":null,
	"rich":null}' "http://10.0.0.11:8015/nc-server-business/nc/business/sendBusinessNotice"

	#记录已经发送过的用户
    echo $userNumber,$userName>>./Result/$NewUserRecord
	fi
	
done

