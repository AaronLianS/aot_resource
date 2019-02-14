account=18117280817
userNumber=66378519
nickName=任夏青


#没特殊情况，realName与nickName一致
realName=$nickName

#组织ID不变，【法院】组织ID为：235984
enterpriseId=235984

#------------------------【更改人员绑定手机号或邮箱（绑定and解绑）】------------------------
#绑定
curl -d "account=$account&userNumber=$userNumber" "http://10.0.0.11:8015/uic-server-user/uic/media/user/accountBinding"

#------------------------【修改人员密码】------------------------
curl -H "Content-Type:application/json" -X POST --data '{
"userNumber":'$userNumber',
"newPwd":"888888"}' "http://10.0.0.11:8015/uic-server-user/uic/media/user/pwd/reset"


#------------------------【修改用户个人资料】------------------------
curl -H "Content-Type:application/json" -X POST --data '{
"userNumber":'$userNumber',
"nickName":"'$nickName'",
"realName":"'$nickName'"
}' "http://10.0.0.11:8015/uic-server-user/uic/user/updateByUserNumber"


#------------------------【修改用户的单位资料】------------------------
curl -H "Content-Type:application/json" -X POST --data '{
 "enterpriseId":'$enterpriseId',
 "userNumber":'$userNumber',
 "realName":"'$nickName'",
 "mobile":""
}' "http://10.0.0.11:8015/uic-server-enterprise/uic/enterprise/buddy/update"

position=上海市金山区人民法院
#------------------------【修改用户的职务信息】------------------------
curl -H "Content-Type:application/json" -X POST --data '{
 "enterpriseId":'$enterpriseId',
 "userNumber":'$userNumber',
 "deptId":"'$deptId'",
 "position":"'$position'"
}' "http://10.0.0.11:8015/uic-server-enterprise/uic/department/member/update"