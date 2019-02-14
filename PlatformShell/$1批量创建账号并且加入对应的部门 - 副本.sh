:'
组织和部门需要实现创建好，部门直接采用导入模式，可以直接批量创建。
脚本依赖的几个必需值。
enterpriseId：组织ID
CreateuserNumber：超级管理员ID

导入的字段格式。
姓名,手机/邮箱帐号,密码,SID,所属部门名称全路径,职位,性别。
请注意字符编码UTF8与换行符UNIX换行。命名为createUjoinE.txt



并且需要用到jq工具，来解析部门json。
wget http://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
rpm -ivh epel-release-latest-7.noarch.rpm
yum repolist
yum -y install jq

'
echo 'lz,18305979565,123456,DEFAULT,城市云运营管理中心-运营管理部,null
lz2,18305979552,123456,DEFAULT,城市云运营管理中心-运营管理部,null
'>createUjoinE.txt

#for test
# username=吴锋
# usermobile=18962128881
# password=123456
# sid=RMZX_ZXT







#【-----------------------------脚本开始-----------------------------------】

#!/bin/sh

#请手动修改
enterpriseId=1000042
CreateuserNumber=70000164

#---------------创建用户--------------
: '
脚本执行后，会在/tmp目录下，生成一个CreateUserResult_加脚本执行时间命名的txt文件，里面包含执行结果。
'

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


CreateUserResultFile=CreateUserResult_`date -d today +"%Y%m%d%H%M%S"`
ChangeSexFile=ChangeSex_`date -d today +"%Y%m%d%H%M%S"`
createuserinfo=createUjoinE.txt
linecount=0

cat $createuserinfo | while read line
do
    username=`echo $line|cut -d ',' -f1`
	usermobile=`echo $line|cut -d ',' -f2`
	
	# password=`echo $line|cut -d ',' -f3`
	#随机密码
	# password=$(generate_passwd)
	#固定密码
	password="123456"
	
	# sid=`echo $line|cut -d ',' -f4`
	sid="SIMBA_AUDIOTONE"
	sex=`echo $line|cut -d ',' -f7`
	
	linetime=`date "+%Y-%m-%d %H:%M:%S"`
	linecount=$(($linecount+1))
	
	c_temp=`curl -d "account=$usermobile&userName=$username&userPwd=$password&sid=$sid" "http://baseserver1:8015/uic-server-user/uic/media/user/account/creat"`
	temp=`echo $c_temp|cut -d ":" -f5|cut -d '"' -f2|cut -d "}" -f1`
	temp2=`echo $c_temp|cut -d ":" -f7|cut -d "}" -f1`
	
	if [ "$temp" = "该账号已被注册!" ];then
		temp2=`curl "http://baseserver1:8015/uic-server-user/uic/user/getUserInfoByAccount?account=$usermobile"|jq .result.userNumber`  
	fi
	
	

	echo $linecount,$linetime,$username,$usermobile,$password,$temp,$temp2>>/tmp/$CreateUserResultFile.txt
	echo $username,$sex,$temp2>>/tmp/$ChangeSexFile.txt
done
#---------------创建用户结束--------------

#----------修改性别----------
ChangeSexFile_result=ChangeSex2result_`date -d today +"%Y%m%d%H%M%S"`

cat /tmp/$ChangeSexFile.txt | while read line
do
	user_number=`echo $line|cut -d ',' -f1`
	sex=`echo $line|cut -d ',' -f2`
	if [ "$sex" = "男" ];then
		sex=1
	fi
	if [ "$sex" = "女" ];then
		sex=2
	fi
	
	c_temp=`curl -H "Content-Type:application/json" -X POST --data '{"userNumber":'$user_number',"sex":'$sex'}' "http://baseserver1:8015/uic-server-user/uic/user/updateByUserNumber"`
	temp=`echo $c_temp|cut -d ":" -f5|cut -d '"' -f2|cut -d "}" -f1`

	echo $user_number,$sex,$temp>>/tmp/$ChangeSexFile_result.txt

done
#----------修改性别结束----------



#---------------获取组织架构树--------------

curl "http://baseserver1:8015/aas-server-authority/aas/authority/departmentProperty/getUserViewTreeByEnterpriseIdAndUserNumber?userNumber=$CreateuserNumber&enterpriseId=$enterpriseId">ent.json

for((i=0;i<=500;i++));  
do
result=`jq ".result.depts[$i]|{deptId:.deptId, deptName:.deptName, depts:.depts }" ent.json`
deptId=`echo $result|jq '.deptId'|sed 's/\"//g'`
deptName=`echo $result|jq '.deptName'|sed 's/\"//g'`

  if [ "$deptId" = "null" ];then
    break  
  fi

echo "$deptId,$deptName;">>deptFullPath.txt
leavel1=`echo $result|jq '.depts'`

#echo $leavel1
 #-------------------------【2】-------------------- 
if [ "$leavel1" != "null" ];then
 for((j=0;j<=500;j++)); 
 do
  result2=`echo $result|jq ".depts[$j]|{deptId:.deptId, deptName:.deptName, depts:.depts }"`
  deptId2=`echo $result2|jq '.deptId'|sed 's/\"//g'`
  deptName2=`echo $result2|jq '.deptName'|sed 's/\"//g'`
  
  leavel2=`echo $result2|jq '.depts'`

  if [ "$deptId2" = "null" ];then
    break  
  fi
  
 #-------------------------【3】-------------------- 
if [ "$leavel2" != "null" ];then
 for((k=0;k<=500;k++)); 
 do
  result3=`echo $result2|jq ".depts[$k]|{deptId:.deptId, deptName:.deptName, depts:.depts }"`
  deptId3=`echo $result3|jq '.deptId'|sed 's/\"//g'`
  deptName3=`echo $result3|jq '.deptName'|sed 's/\"//g'`
  
  leavel3=`echo $result3|jq '.depts'`

  if [ "$deptId3" = "null" ];then
    break  
  fi
  
#-------------------------【4】-------------------- 
if [ "$leavel3" != "null" ];then
 for((l=0;l<=500;l++)); 
 do
  result4=`echo $result3|jq ".depts[$l]|{deptId:.deptId, deptName:.deptName, depts:.depts }"`
  deptId4=`echo $result4|jq '.deptId'|sed 's/\"//g'`
  deptName4=`echo $result4|jq '.deptName'|sed 's/\"//g'`
  
  leavel4=`echo $result4|jq '.depts'`

  if [ "$deptId4" = "null" ];then
    break  
  fi
  
  #-------------------------【5】-------------------- 
if [ "$leavel4" != "null" ];then
 for((p=0;p<=500;p++)); 
 do
  result5=`echo $result4|jq ".depts[$p]|{deptId:.deptId, deptName:.deptName, depts:.depts }"`
  deptId5=`echo $result5|jq '.deptId'|sed 's/\"//g'`
  deptName5=`echo $result5|jq '.deptName'|sed 's/\"//g'`
  
  leavel5=`echo $result5|jq '.depts'`

  if [ "$deptId5" = "null" ];then
    break  
  fi
  
  if [ "$leavel5" = "null" ];then
    continue  
  fi
  
  
  echo "$deptId5,$deptName-$deptName2-$deptName3-$deptName4-$deptName5;">>deptFullPath.txt

 done
 
fi
#-------------------------【5】--------------------
  
  echo "$deptId4,$deptName-$deptName2-$deptName3-$deptName4;">>deptFullPath.txt

 done
 
fi
#-------------------------【4】--------------------
  
  echo "$deptId3,$deptName-$deptName2-$deptName3;">>deptFullPath.txt

 done
 
fi
#-------------------------【3】--------------------
  
  echo "$deptId2,$deptName-$deptName2;">>deptFullPath.txt

 done
 
fi
 #-------------------------【2】-------------------- 
#echo $result|cut -d ':' -f4 |cut -d " " -f2
#echo $result
# echo ----------------------------------------


done

#---------------获取组织架构树结束--------------



#----------批量加入部门(只支持首次添加，之后就需要前往EOS进行调整部门)----------
: '
脚本执行后，会在/tmp目录下，生成一个JoinEntResult_加脚本执行时间命名的txt文件，里面包含执行结果。
'
#!/bin/sh
JoinEntResultFile=JoinEntResult_`date -d today +"%Y%m%d%H%M%S"`
JoinEnt=createUjoinE.txt
linecount=0


cat $JoinEnt | while read line
do
	AccountNumber=`echo $line|cut -d ',' -f2`
	userNumber=`curl "http://baseserver1:8015/uic-server-user/uic/user/getUserInfoByAccount?account=$AccountNumber"|jq .result.userNumber`

	deptFullPath=`echo $line|cut -d ',' -f5`
	deptId=`cat deptFullPath.txt|grep "$deptFullPath;"|cut -d ',' -f1|tail -1`
	

	linetime=`date "+%Y-%m-%d %H:%M:%S"`
	linecount=$(($linecount+1))
	
	c_temp=`curl -H "Content-Type:application/json" -X POST --data '{"enterpriseId":'$enterpriseId',"userNumber":'$userNumber',"deptPositions":[{"deptId":"'$deptId'","position":null}]}' "http://baseserver1:8015/uic-server-enterprise/uic/meida/enterprise/buddy/userJoinEnterprise"`
	temp=`echo $c_temp|cut -d ":" -f5|cut -d '"' -f2|cut -d "}" -f1`
	temp2=`echo $c_temp|cut -d ":" -f7|cut -d "}" -f1`
	echo $linecount,$linetime,$userNumber,$deptId,$deptFullPath,$temp,$temp2>>/tmp/$JoinEntResultFile.txt
done
#----------批量加入部门结束----------


#----------添加职务----------
updateDutyResultFile=updateDutyResult_`date -d today +"%Y%m%d%H%M%S"`
DutyFile=createUjoinE.txt
linecount=0
cat $DutyFile | while read line
do
	AccountNumber=`echo $line|cut -d ',' -f2`
	userNumber=`curl "http://baseserver1:8015/uic-server-user/uic/user/getUserInfoByAccount?account=$AccountNumber"|jq .result.userNumber`

	deptFullPath=`echo $line|cut -d ',' -f5`
	deptId=`cat deptFullPath.txt|grep "$deptFullPath;"|cut -d ',' -f1|tail -1`
	position=`echo $line|cut -d ',' -f6`

	linetime=`date "+%Y-%m-%d %H:%M:%S"`
	linecount=$(($linecount+1))

  c_temp=`curl -H "Content-Type:application/json" -X POST --data '{ "enterpriseId":'$enterpriseId', "userNumber":'$userNumber', "deptId":"'$deptId'", "position":"'$position'"}' "http://baseserver1:8015/uic-server-enterprise/uic/department/member/update"`
	temp=`echo $c_temp|cut -d ":" -f5|cut -d '"' -f2|cut -d "}" -f1`
	temp2=`echo $c_temp|cut -d ":" -f7|cut -d "}" -f1`
	echo $linecount,$linetime,$userNumber,$deptId,$deptFullPath,$temp,$temp2>>/tmp/$updateDutyResultFile.txt
done
#----------添加职务结束----------



#【-----------------------------脚本结束-----------------------------------】