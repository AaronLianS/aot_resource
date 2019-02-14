#添加人员
curl -d "account=18305979552&userName=lz&userPwd=123456&sid=RMZX_ZXT" "http://10.0.0.11:8015/uic-server-user/uic/media/user/account/creat"


#-----------------批量添加人员脚本------------------------
: '
在脚本执行目录下，创建一个createuserinfo.txt。
格式为下(请注意字符编码与换行符)：
吴锋,18962128881
吴锋1,1835489492,888888
吴锋2,1835484833,888888,RMZX_ZXT

姓名，手机号或者邮箱，密码，sid。
默认脚本中，密码与sid，是固定值，根据实际需求更改，将固定值注释即可。同行还有基础服务的IP地址，根据实际环境填写。
脚本执行后，会在/tmp目录下，生成一个脚本执行时间命名的txt文件，里面包含新生成的账号ID。

注：如果不使用脚本，请使用《通过接口添加人员.xls》，在里面添加好资料后，直接复制到一个sh中，执行。
不建议直接复制到命令行中，容易出错。
'

#----------脚本开始-----------------
#以下为随机密码生成，如果为固定密码，就不用管
function generate_passwd()
{
    local arr=( a b c d e f g h g k m n p q r s t u v w x y z
                 1 2 3 5 6 7 8 9)
        #for i in {1...8}
    for ((i=0;i<6;i++))
    do 
        echo -n ${arr[$RANDOM % ${#arr[@]}]}
    done
}
#for test
# username=吴锋
# usermobile=18962128881
# password=123456
# sid=RMZX_ZXT

CreateUserResultFile=CreateUserResult_`date -d today +"%Y%m%d%H%M%S"`
createuserinfo=createuserinfo.txt

cat $createuserinfo | while read line
do
    username=`echo $line|cut -d ',' -f1`
	usermobile=`echo $line|cut -d ',' -f2`
	
	password=`echo $line|cut -d ',' -f3`
	password=$(generate_passwd)
	password="888888"
	
	sid=`echo $line|cut -d ',' -f4`
	sid="RMZX_ZXT"
	
	echo -n $username,$usermobile,$password,>>/tmp/$CreateUserResultFile.txt
	c_temp=`curl -d "account=$usermobile&userName=$username&userPwd=$password&sid=$sid" "http://10.0.0.11:8015/uic-server-user/uic/media/user/account/creat"`
	temp=`echo $c_temp|cut -d ":" -f5|cut -d '"' -f2|cut -d "}" -f1`
	temp2=`echo $c_temp|cut -d ":" -f7|cut -d "}" -f1`
	echo $temp,$temp2>>/tmp/$CreateUserResultFile.txt
done
#----------脚本结束-----------------



#加入部门

curl -H "Content-Type:application/json" -X POST --data '
{"enterpriseId":700087,
"userNumber":61002127,
"deptPositions":[{"deptId":"a0f4ig6xlkl5xpuc","position":null}]}
' "http://10.0.0.11:8015/uic-server-enterprise/uic/meida/enterprise/buddy/userJoinEnterprise"

curl -H "Content-Type:application/json" -X POST --data '{"enterpriseId":700087,"userNumber":61002127,"deptPositions":[{"deptId":"a0f4ig6xlkl5xpuc","position":null}]}' "http://10.0.0.11:8015/uic-server-enterprise/uic/meida/enterprise/buddy/userJoinEnterprise"
curl -H "Content-Type:application/json" -X POST --data '{"enterpriseId":700087,"userNumber":61002127,"deptPositions":[{"deptId":"a0f4ig6xlkl5xpuc","position":null}]}' "http://10.0.0.11:8015/uic-server-enterprise/uic/meida/enterprise/buddy/userJoinEnterprise"

curl -H "Content-Type:application/json" -X POST --data '{"enterpriseId":700087,"userNumber":61002127,"deptPositions":[{"deptId":"a0f4ig6xlkl5xpuc","position":null}]}' "http://10.0.0.11:8015/uic-server-enterprise/uic/meida/enterprise/buddy/userJoinEnterprise"


echo "700087,a0f4ig6xlkl5xpuc
700087,a0f4ig6xlkl5xpuc">joinent.txt
userNumber=700087
deptId=a0f4ig6xlkl5xpuc

#----------批量加入部门脚本开始-----------------


JoinEntResultFile=JoinEntResult_`date -d today +"%Y%m%d%H%M%S"`
JoinEnt=joinent.txt


cat $JoinEnt | while read line
do
	enterpriseId=700087
	userNumber=`echo $line|cut -d ',' -f1`
	deptId=`echo $line|cut -d ',' -f2`
	

	echo -n $userNumber,$deptId,>>/tmp/$JoinEntResultFile.txt
	c_temp=`curl -H "Content-Type:application/json" -X POST --data '{"enterpriseId":'$enterpriseId',"userNumber":'$userNumber',"deptPositions":[{"deptId":"'$deptId'","position":null}]}' "http://10.0.0.11:8015/uic-server-enterprise/uic/meida/enterprise/buddy/userJoinEnterprise"`
	temp=`echo $c_temp|cut -d ":" -f5|cut -d '"' -f2|cut -d "}" -f1`
	temp2=`echo $c_temp|cut -d ":" -f7|cut -d "}" -f1`
	echo $temp,$temp2>>/tmp/$JoinEntResultFile.txt
done



#-----------------------------------------




#获取组织信息
curl "http://10.0.0.11:8015/aas-server-authority/aas/authority/departmentProperty/getUserViewTreeByEnterpriseIdAndUserNumber?userNumber=66617718&enterpriseId=235843"

curl "http://10.0.0.11:8015/uic-server-enterprise/uic/enterprise/getListByUserNumber?userNumber=61002127"


#获取人员信息。
curl "http://10.0.0.11:8015/uic-server-user/uic/user/getUserInfoByAccount?account=18001761560"





create or replace view v_uic_department_info
as
select enterprise_id,parent_dept_id,top_dept_id,dept_id,dept_name from uic_department_info



700087 国网江苏电力

#for test
echo "吴锋,18962128881
吴锋1,1835489492
吴锋2,1835484833">createuserinfo.txt

updatetime=`date -d today +"%Y%m%d%H%M%S"`
createuserinfo=createuserinfo.txt

cat $createuserinfo | while read line
do
    username=`echo $line|cut -d ',' -f1`
	usermobile=`echo $line|cut -d ',' -f2`
	password=`echo $line|cut -d ',' -f3`
	sid=`echo $line|cut -d ',' -f4`
	echo -n $username,$usermobile,>>/tmp/$updatetime.txt
	curl -d "account=$usermobile&userName=$username&userPwd=888888&sid=RMZX_ZXT" "http://10.0.0.11:8015/uic-server-user/uic/media/user/account/creat">/tmp/c.temp
	temp=`cat /tmp/c.temp|cut -d ":" -f7|cut -d "}" -f1`
	echo $temp>>/tmp/$updatetime.txt
done
