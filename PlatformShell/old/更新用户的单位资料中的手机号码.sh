# "enterpriseId":235604,企业ID
# "userNumber":66284709,UC号码
#
curl -H "Content-Type:application/json" -X POST --data '{
 "enterpriseId":235863,
 "userNumber":61000713,
 "mobile":""
}' "http://10.0.0.11:8015/uic-server-enterprise/uic/enterprise/buddy/update"

curl -H "Content-Type:application/json" -X POST --data '{
 "enterpriseId":235984,
 "userNumber":66539559,
 "mobile":""
}' "http://10.0.0.11:8015/uic-server-enterprise/uic/enterprise/buddy/update"



read -p "请输入用户组织ID：" enterpriseId
read -p "请输入用户ID：" userNumber
read -p "请输入用户手机号：" mobile
url="http://10.0.0.11:8015/uic-server-enterprise/uic/enterprise/buddy/update"


# 测试使用
# enterpriseId=235984
# userNumber=61000713
# mobile=

curl -H "Content-Type:application/json" -X POST --data '{
 "enterpriseId":'$enterpriseId',
 "userNumber":'$userNumber',
 "mobile":"'$mobile'"
}' $url

#绑定手机号(可登陆)
curl -d "account=18018887731&userNumber=66126893" "http://10.0.0.11:8015/uic-server-user/uic/media/user/accountBinding"

#移除绑定手机号
curl -d "account=18117255685&userNumber=66539559" "http://10.0.0.11:8015/uic-server-user/uic/media/user/removeBinding"

#修改密码
curl -H "Content-Type:application/json" -X POST --data '{
"userNumber":66126893,
"newPwd":"888888"}' "http://10.0.0.11:8015/uic-server-user/uic/media/user/pwd/reset"

