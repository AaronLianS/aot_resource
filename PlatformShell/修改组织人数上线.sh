#------------------------【修改组织人数上线】------------------------

"objectType":"ENTERPRISE"   固定值，表示组织配置
"objectCode":"MAX_ENTER_MEMBER_NUM" ，固定值，表示组织最大上限人数
"objectKey":"235064"  表示组织ID,需要根据实际配置填写
"objectValue":4  表示上限人数,需要根据实际配置填写

#组织ID
EnterID=$2
#组织人员上线
EnterUserLimit=$3
#数据库主键ID
id=

	curl -H "Content-Type:application/json" -X POST --data '{
		"objectName":"组织成员最大数量","objectType":"ENTERPRISE",
		"objectKey":"'$EnterID'", "objectCode":"MAX_ENTER_MEMBER_NUM",
		"objectValue":'$EnterUserLimit'}' "http://baseserver1:8015/sys-server-config/sys/config/object/limit/addObjectLimit"
		
	curl -H "Content-Type:application/json" -X POST --data '{"id":'$id',
		"objectName":"组织成员最大数量","objectType":"ENTERPRISE",
		"objectKey":"'$EnterID'", "objectCode":"MAX_ENTER_MEMBER_NUM",
		"objectValue":'$EnterUserLimit'}' "http://baseserver1:8015/sys-server-config/sys/config/object/limit/editObjectLimit"

		curl "http://baseserver1:8015/sys-server-config/sys/config/object/limit/deleteObjectLimit?id=$id"

		
select id,object_key,object_value from sys_object_limit
where object_code ='MAX_ENTER_MEMBER_NUM' and object_key <> 0

#-----------------------获取组织的上限人数-----------------------


curl -H "Content-Type:application/json" -X POST --data '{"objectCode":"MAX_ENTER_MEMBER_NUM",
"objectKey":235984,
"objectType":"ENTERPRISE"
}' "http://baseserver1:8015/sys-server-config/sys/config/object/limit/getConfig"


#-------------------------------以下为脚本内容-----------------------------------

#sh XXXX.sh 1 enterid 100

#类型（1为修改组织用户上限，2为删除组织的上限，变为默认的）
Type=$1
#组织ID
EnterID=$2
#组织人员上线
EnterUserLimit=$3


#开始从数据库中获取该组织对应的主键ID
rm -rf /var/lib/mysql-files/EnteruserLimit.txt
echo "select concat(id,',',object_key,',',object_value) into outfile '/var/lib/mysql-files/EnteruserLimit.txt' from sys_object_limit
where object_code ='MAX_ENTER_MEMBER_NUM' and object_key <> 0 and object_key='$EnterID'">EnteruserLimit.sql
mysql -u root -pwww.simba.pro simba_db1<EnteruserLimit.sql
rm -rf EnteruserLimit.sql

id=`cat /var/lib/mysql-files/EnteruserLimit.txt|cut -d ',' -f1`
#数据库ID
echo $id

if [ "$Type" = "1" ];then


  if [ "$id" = "" ];then
	#为企业添加上限脚本：
	curl -H "Content-Type:application/json" -X POST --data '{
		"objectName":"组织成员最大数量","objectType":"ENTERPRISE",
		"objectKey":"'$EnterID'", "objectCode":"MAX_ENTER_MEMBER_NUM",
		"objectValue":'$EnterUserLimit'}' "http://baseserver1:8015/sys-server-config/sys/config/object/limit/addObjectLimit"
	else
	#为企业修改上限脚本：
	curl -H "Content-Type:application/json" -X POST --data '{"id":'$id',
		"objectName":"组织成员最大数量","objectType":"ENTERPRISE",
		"objectKey":"'$EnterID'", "objectCode":"MAX_ENTER_MEMBER_NUM",
		"objectValue":'$EnterUserLimit'}' "http://baseserver1:8015/sys-server-config/sys/config/object/limit/editObjectLimit"
  fi
	

fi

#-----------------------------------

if [ "$Type" = "2" ];then
#为企业删除上限脚本：
curl "http://baseserver1:8015/sys-server-config/sys/config/object/limit/deleteObjectLimit?id=$id"

fi




