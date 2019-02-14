#------------------------【获取人员所有组织信息】------------------------
curl -H "Content-Type:application/json" -X POST --data '{
"pageSize":5000,
"enterpriseName":null,
"userNumber":null,
"startCreateTime":null,
"endCreateTime":null,
"minBuddyNum":null,
"maxBuddyNum":null,
"sidCode":"YIYU_JXHT_PARENT"}' "http://base1.simba.pro:8015/uic-server-enterprise/uic/meida/enterprise/getPageEnterpriseInfo">ent.json


cat ent.json |jq '.result.resultList[].enterName'>AllEnterName.txt
#去掉双引号
sed -i 's/"//g' AllEnterName.txt
busid=`date -d today +"%Y%m%d%H%M%S"`
count=1

cat AllEnterName.txt| while read line
do
 	temp=`cat AlreadySend.txt|grep $line`
	if [ "$temp" = "" ];then
		curl -H "Content-Type:application/json" -X POST --data '{
			"bizTypeCode":"notice",
			"templateCode":"notice_general",
			"businessId":"yiyu'$busid$count'",
			"subject":"易宇创建了新组织",
			"summary":null,
			"content":"易宇创建了新组织，组织名称：'$line'",
			"enterId":null,
			"enterName":null,
			"imageUrl":null,
			"attachNum":0,
			"feedbackFlag":null,
			"version":null,
			"sender":10000,
			"receivers":[66120270,66009927],
			"form":null,
			"multiContent":null,
			"rich":null}' "http://base1.simba.pro:8015/nc-server-business/nc/business/sendBusinessNotice"
		echo $line>>AlreadySend.txt
		count=$(($count+1))
    fi
	

done


