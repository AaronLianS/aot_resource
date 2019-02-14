#!/bin/bash
cd /root/trial
mkdir Result

#开始获取今天申请创建组织的用户信息
curl https://app.peopleyun.cn/zxtopen/kefu/getapplyinfo.php>applyent.txt


CreateEntResultFile=CreateEntResult_`date -d today +"%Y%m%d"`.txt
CreateSuc=CreateSuc_`date -d today +"%Y%m%d"`.txt
CreateSucAll=CreateSucAll.txt
TodayAlreadCreateNotice=TodayAlreadCreateNotice_`date -d today +"%Y%m%d"`.txt
CreateFail=CreateFailResult.txt

# echo '用户ID,单位名称,联系人,联系电话
# 61009654,123,联系人,联系电话'>applyent.txt

cat applyent.txt| while read line
do
	userNumber=`echo $line|cut -d ',' -f1`
	if [ "$userNumber" = "" ];then
      continue;
    fi
	
	enterName=`echo $line|cut -d ',' -f2`
	
	if [ "$userNumber" = "用户ID" ];then
	continue;
	fi

	#-------------------------
	deteCreate=`cat $CreateSuc|grep $userNumber`
	if [ "$deteCreate" != "" ];then
#	  getTodayAlreadCreateNotice=`cat $TodayAlreadCreateNotice|grep $userNumber`
#	 if [ "$getTodayAlreadCreateNotice" = "" ];then
#	echo $userNumber,$enterName>>$TodayAlreadCreateNotice
#	curl -H "Content-Type:application/json" -X POST --data '{
#	"bizTypeCode":"notice",
#	"templateCode":"notice_general",
#	"businessId":"99998",
#	"subject":"您今日已经创建过组织",
#	"summary":null,
#	"content":"您今日已经创建过组织，请明日重试。",
#	"enterId":null,
#	"enterName":null,
#	"imageUrl":null,
#	"attachNum":0,
#	"feedbackFlag":null,
#	"linkUrl":"https://app.peopleyun.cn/zxtopen/trialnotice/createentalready.html",
#	"pointLink":"https://app.peopleyun.cn/zxtopen/trialnotice/createentalready.html",
#	"version":null,
#	"sender":10000,
#	"receivers":['$userNumber'],
#	"form":null,
#	"multiContent":null,
#	"rich":null}' "http://10.0.0.11:8015/nc-server-business/nc/business/sendBusinessNotice"
#	continue;
#	 fi
continue;
	fi
#-------------------------
	
	# userNumber=61009654
	# enterName=测试组织安安
	
result=`curl -H "Content-Type:application/json" -X POST --data '{
 "userNumber":'$userNumber',
 "enterName":"'$enterName'",
 "sid":"RMZX_ZXTOPEN"
}' "http://baseserver1:8015/uic-server-enterprise/uic/enterprise/create"`
result1=`echo $result|cut -d ":" -f5|cut -d '"' -f2|cut -d "}" -f1`
enterpriseId=`echo $result|cut -d ":" -f7|cut -d "}" -f1`
echo $userNumber,$enterName,$result1,$enterpriseId>>./Result/$CreateEntResultFile

# 已存在相同名称的组织
# 操作成功

	if [ "$result1" = "操作成功" ];then
	echo -n $enterpriseId,>>Entinfo.txt
	echo $userNumber,$enterName,$enterpriseId>>$CreateSuc
	echo $userNumber,$enterName>>$CreateFail
	echo $userNumber,$enterName>>$CreateSucAll
	curl -H "Content-Type:application/json" -X POST --data '{
	"bizTypeCode":"notice",
	"templateCode":"notice_general",
	"businessId":"99998",
	"subject":"创建组织成功",
	"summary":null,
	"content":"您申请创建组织已经通过",
	"enterId":null,
	"enterName":null,
	"imageUrl":null,
	"attachNum":0,
	"feedbackFlag":null,
	"linkUrl":"https://app.peopleyun.cn/zxtopen/trialnotice/createentsuccess.html",
	"pointLink":"https://app.peopleyun.cn/zxtopen/trialnotice/createentsuccess.html",
	"version":null,
	"sender":10000,
	"receivers":['$userNumber'],
	"form":null,
	"multiContent":null,
	"rich":null}' "http://10.0.0.11:8015/nc-server-business/nc/business/sendBusinessNotice"
	continue;
	fi

	
deteEnterName=`cat $CreateFail|grep $enterName`
if [ "$deteEnterName" != "" ];then
	continue;
fi
echo $userNumber,$enterName>>$CreateFail
	
	if [ "$result1" = "已存在相同名称的组织。" ];then

	curl -H "Content-Type:application/json" -X POST --data '{
	"bizTypeCode":"notice",
	"templateCode":"notice_general",
	"businessId":"99998",
	"subject":"创建组织失败",
	"summary":null,
	"content":"您申请创建组织失败",
	"enterId":null,
	"enterName":null,
	"imageUrl":null,
	"attachNum":0,
	"feedbackFlag":null,
	"linkUrl":"https://app.peopleyun.cn/zxtopen/trialnotice/createentfail.html",
	"pointLink":"https://app.peopleyun.cn/zxtopen/trialnotice/createentfail.html",
	"version":null,
	"sender":10000,
	"receivers":['$userNumber'],
	"form":null,
	"multiContent":null,
	"rich":null}' "http://10.0.0.11:8015/nc-server-business/nc/business/sendBusinessNotice"
	# else
	# curl -H "Content-Type:application/json" -X POST --data '{
	# "bizTypeCode":"notice",
	# "templateCode":"notice_general",
	# "businessId":"99998",
	# "subject":"创建组织失败",
	# "summary":null,
	# "content":"您申请创建组织失败",
	# "enterId":null,
	# "enterName":null,
	# "imageUrl":null,
	# "attachNum":0,
	# "feedbackFlag":null,
	# "linkUrl":"https://app.peopleyun.cn/zxtopen/trialnotice/createentfail2.html",
	# "pointLink":"https://app.peopleyun.cn/zxtopen/trialnotice/createentfail2.html",
	# "version":null,
	# "sender":10000,
	# "receivers":['$userNumber'],
	# "form":null,
	# "multiContent":null,
	# "rich":null}' "http://10.0.0.11:8015/nc-server-business/nc/business/sendBusinessNotice"
	fi
	

done

#更新联系用户页面
cd /root/trial
sh /root/trial/updatecontactuserweb.sh

