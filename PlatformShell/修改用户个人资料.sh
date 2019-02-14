#------------------------【修改用户个人资料】------------------------

# "userNumber":账号
# "nickName":"昵称"
# "realName":"姓名"
# "mobile":绑定手机号
# "sex":1男2女

curl -H "Content-Type:application/json" -X POST --data '{
"userNumber":66557562,
"nickName":"连政",
"realName":"连政",
"sex":1
}' "http://baseserver1:8015/uic-server-user/uic/user/updateByUserNumber"






# 测试使用
enterpriseId=235984
userNumber=61000713
mobile=
url="http://10.0.0.11:8015/uic-server-user/uic/user/updateByUserNumber"

curl -H "Content-Type:application/json" -X POST --data '{
 "enterpriseId":'$enterpriseId',
 "userNumber":'$userNumber',
 "mobile":"'$mobile'"
}' $url
