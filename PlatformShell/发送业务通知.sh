


#------------------------【发送业务通知】------------------------
curl -H "Content-Type:application/json" -X POST --data '{
"bizTypeCode":"notice",
"templateCode":"notice_general",
"businessId":"99999",
"subject":"温馨提示",
"summary":null,
"content":"温馨提示，试用即将到期",
"enterId":null,
"enterName":null,
"imageUrl":null,
"attachNum":0,
"feedbackFlag":null,
"linkUrl":"http://120.131.9.86:801/trialnotice/",
"pointLink":"http://120.131.9.86:801/trialnotice/",
"version":null,
"sender":10000,
"receivers":[66557562,61009654],
"form":null,
"multiContent":null,
"rich":null}' "http://10.0.0.11:8015/nc-server-business/nc/business/sendBusinessNotice"

66521981,61000912




curl -H "Content-Type:application/json" -X POST --data '{
"bizTypeCode":"notice",
"templateCode":"notice_general",
"businessId":"gaoftest1",
"subject":"《全国法院舆论引导工作通报》素材报送通知",
"summary":null,
"content":"《全国法院舆论引导工作通报》素材报送通知",
"enterId":null,
"enterName":null,
"imageUrl":null,
"attachNum":0,
"feedbackFlag":null,
"linkUrl":"https://app.peopleyun.cn/common/gaofa/msgnotice.php?workmonth=01&endyear=2019&endmonth=2",
"pointLink":"https://app.peopleyun.cn/common/gaofa/msgnotice.php?workmonth=01&endyear=2019&endmonth=2",
"version":null,
"sender":10000,
"receivers":[61001015],
"form":null,
"multiContent":null,
"rich":null}' "http://10.0.0.11:8015/nc-server-business/nc/business/sendBusinessNotice"



curl -H "Content-Type:application/json" -X POST --data '{
"bizTypeCode":"notice",
"templateCode":"notice_general",
"businessId":"IOSUPDATE_1",
"subject":"IOS客户端升级通知",
"summary":null,
"content":"IOS客户端证书升级，请点击升级。",
"enterId":null,
"enterName":null,
"imageUrl":null,
"attachNum":0,
"feedbackFlag":null,
"linkUrl":"https://app.peopleyun.cn/download",
"pointLink":"https://app.peopleyun.cn/download",
"version":null,
"sender":10000,
"receivers":[61000042,61000044],
"form":null,
"multiContent":null,
"rich":null}' "http://10.0.0.11:8015/nc-server-business/nc/business/sendBusinessNotice"






























#------------------------【以下无用】------------------------

curl -H "Content-Type:application/json" -X POST --data '{"userNumber": 65656565}' "http://172.16.39.62:8015/uic-server-user/uic/media/user/accountCancel"



<request type="appNotifyService" subtype="sendNotify" msid="">
<account>66557562</account>
<message>
<sync>0</sync>
<receiver>66557562</receiver>
<recv_terminal>3</recv_terminal>
<content><![CDATA[eyJhY2NOYnIiOiI2NjM1OTMzNyIsImJ1c0lkIjoiMSIsImNvbnRleHQiOiLmnKzmnIjntKDmnZDmiKrmraIyMDE4LTA4LTMx5YmN5o+Q5LqkIiwiZGV0YWlsVXJsIjoiaHR0cDovLzEyMC4xMzEuMTIuMTc0OjgwODIvemdmeXkvbXAvc3VibWl0TGlzdC5odG1sIiwiZW50ZXJJZCI6MjM1OTg0LCJlbnRlck5hbWUiOiLmnIDpq5jms5XnvZHmiqUiLCJpbWFnZVVybCI6bnVsbCwibXNnVHlwZSI6Iue0oOadkOaKpemAgemAmuefpSIsInNlbmRUaW1lIjoxNTM0MjI5NDc4NjMyLCJ0aXRsZSI6IuOAiuWFqOWbveazlemZouiIhuiuuuW8leWvvOW3peS9nOmAmuaKpeOAi+e0oOadkOaKpemAgemAmuefpSIsInVpVHlwZSI6MiwidXNlck5hbWUiOiLnrqHnkIblkZgifQ==]]></content>
</message>
</request>

"http://120.131.11.11:8040/AppCentercxtd/service"


echo $[$(date +%s%N)/1000000]

echo '{"accNbr":"66557562","busId":"12412512515","context":"试用通知","detailUrl":"http://120.131.12.174:8082/zgfyy/mp/submitList.html","imageUrl":null,"msgType":"通知公告","sendTime":'$[$(date +%s%N)/1000000]',"title":"试用通知","uiType":2,"userName":"管理员"}'>send.txt
base64 send.txt>result.txt
SendNoticeBase64=`cat result.txt|awk 'BEGIN{ORS=" "}{print $0}'|sed s/[[:space:]]//g`
echo $SendNoticeBase64
SendNotice=`echo '<?xml version="1.0" encoding="utf-8"?><request type="appNotifyService" subtype="sendNotify" msid=""><account>66557562</account><message><sync>0</sync><receiver>66557562</receiver><recv_terminal>3</recv_terminal><content><![CDATA['$SendNoticeBase64']]></content></message></request>'`


curl -d ""http://120.131.11.11:8040/AppCentercxtd/service""


echo '<?xml version="1.0" encoding="utf-8"?><request type="appNotifyService" subtype="sendNotify" msid=""><account>66557562</account><message><sync>0</sync><receiver>66557562</receiver><recv_terminal>3</recv_terminal><content><![CDATA[eyJhY2NOYnIiOiI2NjM1OTMzNyIsImJ1c0lkIjoiMTI0MTI1MTI1MTUiLCJjb250ZXh0Ijoi6K+V55So6YCa55+lIiwiZGV0YWlsVXJsIjoiaHR0cDovLzEyMC4xMzEuMTIuMTc0OjgwODIvemdmeXkvbXAvc3VibWl0TGlzdC5odG1sIiwiaW1hZ2VVcmwiOm51bGwsIm1zZ1R5cGUiOiLpgJrnn6XlhazlkYoiLCJzZW5kVGltZSI6MTUzOTE0NjQxMTQwMiwidGl0bGUiOiLor5XnlKjpgJrnn6UiLCJ1aVR5cGUiOjIsInVzZXJOYW1lIjoi566h55CG5ZGYIn0K]]></content></message></request>'|curl -X POST -H 'Content-type:text/xml' -d @- http://120.131.11.11:8041/service


curl -H 'request' -H '57000' -H "Content-Type:application/xml" -X POST --data '<request type="appNotifyService" subtype="sendNotify" msid="">
  <account>66557562</account>
  <message>
    <sync>0</sync>
    <receiver>66557562</receiver>    <content><![CDATA[eyJhY2NOYnIiOiI2NjM1OTMzNyIsImJ1c0lkIjoiMTI0MTI1MTI1MTUiLCJjb250ZXh0Ijoi6K+V55So6YCa55+lIiwiZGV0YWlsVXJsIjoiaHR0cDovLzEyMC4xMzEuMTIuMTc0OjgwODIvemdmeXkvbXAvc3VibWl0TGlzdC5odG1sIiwiaW1hZ2VVcmwiOm51bGwsIm1zZ1R5cGUiOiLpgJrnn6XlhazlkYoiLCJzZW5kVGltZSI6MTUzOTE0NjQxMTQwMiwidGl0bGUiOiLor5XnlKjpgJrnn6UiLCJ1aVR5cGUiOjIsInVzZXJOYW1lIjoi566h55CG5ZGYIn0K]]></content>
  </message>
</request>' "http://120.131.11.11:8040/service"


curl -H "Content-Type:text/xml" -X POST --data '
<?xml version="1.0" encoding="utf-8"?>
  <request type="user" subtype="getCustNbrInfo" msid="">
    <token>a0f09m060emugvfb</token>
    <message>
      <user acc_nbr="61000031" />
    </message>
  </request>' "http://120.131.11.11:8041/service"
  




tr -s '\n' < result.txt

| base64|awk 'BEGIN{ORS=" "}{print $0}'|sed s/[[:space:]]//g


cat send.txt | xxd -r -ps | base64


echo '{"accNbr":"66359337","busId":"1","context":"本月素材截止2018-08-31前提交","detailUrl":"http"imageUrl":null,"msgType":"通知公告","sendTime":'$[$(date +%s%N)/1000000]',"title":"《全国法院舆论引导工作通报》素材报送通知","uiType":2,"userName":"管理员"}' | base64|awk 'BEGIN{ORS=" "}{print $0}'



