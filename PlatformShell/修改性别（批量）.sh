cat /tmp/CreateUserResult_20190125162800.txt | while read line
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
	echo $user_number,$sex,$temp>>/tmp/CreateUserResult_20190125162800_sexResult.txt

done
