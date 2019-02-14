#------------------------【login】------------------------

curl -H "Content-Type:application/json" -X POST --data '{"token":"a0f6m868m29s3xeb","enterpriseId":237222}' "http://47.95.146.57:18080/attendance/auth/record/outsideAttend"



curl -H "Content-Type:application/json" -X POST -H 'Authorization: eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJTaW1iYUVvc1dlYiIsImF1ZCI6ImEwZjZtODY4bTI5czN4ZWIiLCJuYmYiOjE1NDMzMTEwNjcsImlzcyI6InNpd192ZXJpZnkiLCJlbnRlcnByaXNlSWQiOiIyMzcyMjIiLCJleHAiOjE1NDM2NjE1MjUsImlhdCI6MTU0MzMxMTA2NywidXNlck51bWJlciI6IjY2MTIwMjcwIiwianRpIjoiYjRhMTIxZWUtNTVmNi00NTY0LWIwYTQtY2RlYWQxYWI0MDY3In0.4jx5B7BYvbWBGo8uPSfDxVLh3BDtD2Fxj5z9r2GrIfI' --data '{"address":"福建省福州市鼓楼区北二环中路靠近华大街道体育中心社区居委会","enterpriseId":237222,"groupId":635,"latitude":26.110296,"longitude":119.303177,"recordId":92609,"time":1543311169167,"workType":1}' "http://47.95.146.57:18080/attendance/auth/record/outsideAttend"

address=福建省福州市鼓楼区北二环中路靠近金汤假日公园 
enterpriseId=235604
groupId=484
latitude=26.110526
longitude=119.303188
recordId=42175
time=1537270484947
workType=2

{"address":"福建省福州市鼓楼区北二环中路靠近金汤假日公园 ","enterpriseId":235604,"groupId":484,"latitude":26.110373,"longitude":119.303192,"recordId":42976,"time":1537316563818,"workType":1}




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
