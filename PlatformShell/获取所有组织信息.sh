#------------------------【获取人员所有组织信息】------------------------
curl -H "Content-Type:application/json" -X POST --data '{
"pageSize":5000,
"enterpriseName":null,
"userNumber":null,
"startCreateTime":null,
"endCreateTime":null,
"minBuddyNum":null,
"maxBuddyNum":null,
"sidCode":"YIYU_JXHT_PARENT"}' "http://base1.simba.pro:8015/uic-server-enterprise/uic/meida/enterprise/getPageEnterpriseInfo"
