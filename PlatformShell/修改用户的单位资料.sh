#------------------------【修改用户的单位资料】------------------------

# "enterpriseId":235604,企业ID，必填
# "userNumber":66284709,UC号码，必填
# "realName":"姓名"
# "mobile":"手机号"
#
curl -H "Content-Type:application/json" -X POST --data '{
 "enterpriseId":235863,
 "userNumber":66557562,
 "realName":"连政",
  "mobile":""
}' "http://10.0.0.11:8015/uic-server-enterprise/uic/enterprise/buddy/update"



curl -H "Content-Type:application/json" -X POST --data '{
 "enterpriseId":235863,
 "userNumber":66557562,
 "realName":"连政",
  "mobile":""
}' "http://10.0.0.11:8015/uic-server-enterprise/uic/department/member/update"



# 测试使用
enterpriseId=235984
userNumber=61000713
mobile=
url="http://10.0.0.11:8015/uic-server-enterprise/uic/enterprise/buddy/update"

curl -H "Content-Type:application/json" -X POST --data '{
 "enterpriseId":'$enterpriseId',
 "userNumber":'$userNumber',
 "mobile":"'$mobile'"
}' $url


#------------------------【修改用户的职务信息】------------------------

enterpriseId=5
userNumber=70028850
deptId=a0f55locv7ay8zps
url="http://baseserver1:8015/uic-server-enterprise/uic/enterprise/buddy/update"

curl -H "Content-Type:application/json" -X POST --data '{
 "enterpriseId":'$enterpriseId',
 "userNumber":'$userNumber',
 "deptId":"'$deptId'",
 "position":"总账会计"
}' "http://baseserver1:8015/uic-server-enterprise/uic/department/member/update"

curl -H "Content-Type:application/json" -X POST --data '{
 "enterpriseId":5,
 "userNumber":70028850,
 "deptId":"a0f55locv7ay8zps",
 "position":"总账会计"
}' "http://baseserver1:8015/uic-server-enterprise/uic/department/member/update"