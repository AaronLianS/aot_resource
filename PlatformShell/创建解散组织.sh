#创建组织
userNumber=70050023
enterpriseName=北京海关
enterpriseId=700140

curl -H "Content-Type:application/json" -X POST --data '{
 "userNumber":'$userNumber',
 "enterName":"'$enterpriseName'",
 "sid":"RMZX_YQT"
}' "http://base1.zxt.pro:8015/uic-server-enterprise/uic/enterprise/create"


#解散组织

enterpriseId=1000033
userNumber=70000202
enterpriseName=测试测试

curl -X GET -G --data-urlencode "enterpriseName=$enterpriseName" "http://baseserver1:8015/uic-server-enterprise/uic/enterprise/dissolve?enterpriseId=$enterpriseId&userNumber=$userNumber"


