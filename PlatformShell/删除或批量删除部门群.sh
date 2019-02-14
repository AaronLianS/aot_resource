#------------------------【删除部门群】------------------------

: '
enterpriseId=组织id
deptId=部门ID
groupNumber=群号码
userNumber=创建者
'
curl "http://172.16.39.62:8015/uic-server-group/uic/group/dissolveDeptOrEnterpriseGroup?enterpriseId=$enterpriseId&deptId=$deptId&groupNumber=$groupNumber&userNumber=$userNumber"

#----------批量删除部门群脚本----------
: '
在脚本执行目录下，创建一个dissolveDeptorEnt.txt。
格式为下(请注意字符编码UTF8与换行符UNIX格式)：
enterpriseId,deptId,groupNumber,userNumber

基础服务的IP地址，根据实际环境填写。
脚本执行后，会在/tmp目录下，生成一个dissolveDeptorEnt_加脚本执行时间命名的txt文件，里面包含执行结果。

'
#取部门ID等相关信息
select a.enterprise_id,a.dept_id,a.group_number,b.user_number  from uic_group_info a inner join uic_enterprise_info b on a.enterprise_id=b.id 
where a.group_type=3 and a.state=0 and b.enter_name in('新媒通');

#for test
enterpriseId=235952
deptId=394968
groupNumber=394968
userNumber=66592962

#----------脚本开始----------

#!/bin/sh
ResultFile=dissolveDeptorEnt_`date -d today +"%Y%m%d%H%M%S"`
file=dissolveDeptorEnt.txt

linecount=0

cat $file | while read line
do
	enterpriseId=`echo $line|cut -d ',' -f1`
	deptId=`echo $line|cut -d ',' -f2`
	groupNumber=`echo $line|cut -d ',' -f3`
	userNumber=`echo $line|cut -d ',' -f4`
	
	linetime=`date "+%Y-%m-%d %H:%M:%S"`
	linecount=$(($linecount+1))
	c_temp=`curl "http://172.16.39.62:8015/uic-server-group/uic/group/dissolveDeptOrEnterpriseGroup?enterpriseId=$enterpriseId&deptId=$deptId&groupNumber=$groupNumber&userNumber=$userNumber"`
	temp=`echo $c_temp|cut -d ":" -f5|cut -d '"' -f2|cut -d "}" -f1`
	echo $linecount,$linetime,$enterpriseId,$deptId,$groupNumber,$temp>>/tmp/$ResultFile.txt
done
#----------脚本结束----------
