#!/bin/bash
cd /root/trial
mkdir Result

#开始获取今天申请创建组织的用户信息
curl https://app.peopleyun.cn/zxtopen/kefu/getapplyinfo.php>applyent.txt


CreateEntResultFile=CreateEntResult_`date -d today +"%Y%m%d"`.txt
CreateSucAll=CreateSucAll.txt


# echo '用户ID,单位名称,联系人,联系电话,时间
# 61009654,123,联系人,联系电话'>applyent.txt

cat applyent.txt| while read line
do
	#获取用户ID与组织名称
	userNumber=`echo $line|cut -d ',' -f1`
	enterName=`echo $line|cut -d ',' -f2`
	Submitdate=`echo $line|cut -d ',' -f5`
	#跳过无效的数据
	if [ "$userNumber" = "" ];then
    	continue;
    fi	
	if [ "$userNumber" = "用户ID" ];then
		continue;
	fi
	
	#判断今天的输出结果里面，有已经申请创建的组织信息，如果有的话，那就跳过本次循环。
	AlreadyDone=`cat ./Result/$CreateEntResultFile|grep "$userNumber,$Submitdate,$enterName,"`
	if [ "$AlreadyDone" != "" ];then
		continue;
	fi

	#开始创建组织
	result=`curl -H "Content-Type:application/json" -X POST --data '{
 	"userNumber":'$userNumber',
 	"enterName":"'$enterName'",
 	"sid":"RMZX_ZXTOPEN"
	}' "http://baseserver1:8015/uic-server-enterprise/uic/enterprise/create"`
	result1=`echo $result|cut -d ":" -f5|cut -d '"' -f2|cut -d "}" -f1`
	enterpriseId=`echo $result|cut -d ":" -f7|cut -d "}" -f1`


	#开始判断创建的结果，并且进行通知。
	if [ "$result1" = "操作成功" ];then
		#成功的数据，需要加入到Entinfo里面，由另外一个判断组织创建天数的脚本进行读取。
		echo -n $enterpriseId,>>Entinfo.txt
		#保存创建组织的结果
		echo $userNumber,$Submitdate,$enterName,$result1,$enterpriseId>>./Result/$CreateEntResultFile
		#保存成功数据，给联系用户的页面脚本使用。
		echo $userNumber,$enterName>>$CreateSucAll
		#开始执行联系用户的脚本
		sh /root/trial/updatecontactuserweb.sh
		#发送业务通知
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


	if [ "$result1" = "已存在相同名称的组织。" ];then
		#保存这个名称重复的组织。
		echo $userNumber,$Submitdate,$enterName,$result1,$enterpriseId>>./Result/$CreateEntResultFile
		#发送业务通知
		curl -H "Content-Type:application/json" -X POST --data '{
		"bizTypeCode":"notice",
		"templateCode":"notice_general",
		"businessId":"99998",
		"subject":"创建组织失败",
		"summary":null,
		"content":"您申请创建的组织名称已存在。",
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
		continue;
	fi

	if [ "$result1" = "请先绑定手机或邮箱!" ];then
		#保存结果。
		echo $userNumber,$Submitdate,$enterName,$result1,$enterpriseId>>./Result/$CreateEntResultFile
		#发送业务通知
		curl -H "Content-Type:application/json" -X POST --data '{
		"bizTypeCode":"notice",
		"templateCode":"notice_general",
		"businessId":"99998",
		"subject":"创建组织失败",
		"summary":null,
		"content":"请先绑定手机或邮箱!",
		"enterId":null,
		"enterName":null,
		"imageUrl":null,
		"attachNum":0,
		"feedbackFlag":null,
		"linkUrl":"https://app.peopleyun.cn/zxtopen/trialnotice/createentfail2.html",
		"pointLink":"https://app.peopleyun.cn/zxtopen/trialnotice/createentfail2.html",
		"version":null,
		"sender":10000,
		"receivers":['$userNumber'],
		"form":null,
		"multiContent":null,
		"rich":null}' "http://10.0.0.11:8015/nc-server-business/nc/business/sendBusinessNotice"
		continue;
	fi
done

#end