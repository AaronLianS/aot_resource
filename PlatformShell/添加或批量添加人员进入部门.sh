#------------------------【添加人员进入部门】------------------------
curl -H "Content-Type:application/json" -X POST --data '
{"enterpriseId":235923,
"userNumber":66093129,
"deptPositions":[{"deptId":"282926","position":null}]}
' "http://10.0.0.11:8015/uic-server-enterprise/uic/meida/enterprise/buddy/userJoinEnterprise"

curl -H "Content-Type:application/json" -X POST --data '{"enterpriseId":700087,"userNumber":61002127,"deptPositions":[{"deptId":"a0f4ig6xlkl5xpuc","position":null}]}' "http://10.0.0.11:8015/uic-server-enterprise/uic/meida/enterprise/buddy/userJoinEnterprise"



curl -H "Content-Type:application/json" -X POST --data '{"enterpriseId":700087,"userNumber":61002127,"deptPositions":[{"deptId":"a0f4ig6xlkl5xpuc","position":null}]}' "http://10.0.0.11:8015/uic-server-enterprise/uic/meida/enterprise/buddy/userJoinEnterprise"
/uic/meida/enterprise/buddy/userJoinEnterprise


#----------批量加入部门脚本开始----------
: '
在脚本执行目录下，创建一个joinent.txt。
格式为下(请注意字符编码与换行符)：
61002127,a0f4ig6xlkl5xpuc

ID号，部门ID
默认脚本中，组织ID，是固定值，根据实际需求更改。同行还有基础服务的IP地址，根据实际环境填写。
脚本执行后，会在/tmp目录下，生成一个JoinEntResult_加脚本执行时间命名的txt文件，里面包含执行结果。
'
#!/bin/sh
JoinEntResultFile=JoinEntResult_`date -d today +"%Y%m%d%H%M%S"`
JoinEnt=joinent.txt
linecount=0

cat $JoinEnt | while read line
do
	enterpriseId=700087
	userNumber=`echo $line|cut -d ',' -f1`
	deptId=`echo $line|cut -d ',' -f2`
	

	linetime=`date "+%Y-%m-%d %H:%M:%S"`
	linecount=$(($linecount+1))
	
	c_temp=`curl -H "Content-Type:application/json" -X POST --data '{"enterpriseId":'$enterpriseId',"userNumber":'$userNumber',"deptPositions":[{"deptId":"'$deptId'","position":null}]}' "http://10.0.0.11:8015/uic-server-enterprise/uic/meida/enterprise/buddy/userJoinEnterprise"`
	temp=`echo $c_temp|cut -d ":" -f5|cut -d '"' -f2|cut -d "}" -f1`
	temp2=`echo $c_temp|cut -d ":" -f7|cut -d "}" -f1`
	echo $linecount,$linetime,$userNumber,$deptId,$temp,$temp2>>/tmp/$JoinEntResultFile.txt
done


#----------脚本结束----------

#----------配合<获取组织架构树>脚本，批量加入部门，脚本开始----------
: '
在脚本执行目录下，创建一个joinent.txt。
格式为下(请注意字符编码与换行符)：
61002127,检察-天津市人民检察院第一分院

ID号，部门全路径
同行还有基础服务的IP地址，根据实际环境填写。
脚本执行后，会在/tmp目录下，生成一个JoinEntResult_加脚本执行时间命名的txt文件，里面包含执行结果。
'
#!/bin/sh
JoinEntResultFile=JoinEntResult_`date -d today +"%Y%m%d%H%M%S"`
JoinEnt=joinent.txt
linecount=0
#组织ID
enterpriseId=700087

cat $JoinEnt | while read line
do
	userNumber=`echo $line|cut -d ',' -f1`
	deptFullPath=`echo $line|cut -d ',' -f2`
	deptId=`cat deptFullPath.txt|grep "$deptFullPath;"|cut -d ',' -f1|tail -1`
	

	linetime=`date "+%Y-%m-%d %H:%M:%S"`
	linecount=$(($linecount+1))
	
	c_temp=`curl -H "Content-Type:application/json" -X POST --data '{"enterpriseId":'$enterpriseId',"userNumber":'$userNumber',"deptPositions":[{"deptId":"'$deptId'","position":null}]}' "http://10.0.0.11:8015/uic-server-enterprise/uic/meida/enterprise/buddy/userJoinEnterprise"`
	temp=`echo $c_temp|cut -d ":" -f5|cut -d '"' -f2|cut -d "}" -f1`
	temp2=`echo $c_temp|cut -d ":" -f7|cut -d "}" -f1`
	echo $linecount,$linetime,$userNumber,$deptId,$temp,$temp2>>/tmp/$JoinEntResultFile.txt
done


#----------脚本结束----------