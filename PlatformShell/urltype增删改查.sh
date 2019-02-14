#查看urltype
curl -H "Content-Type:application/json" -X POST --data '
{"urlType":null,
"pageSize":30,
"remark":null,
"page":1,
"url":null,
"sid":null
}' "http://10.0.0.11:8015/sys-server-config/sys/config/url/getPageUrlInterface"

#变更urltype信息
curl -H "Content-Type:application/json" -X POST --data '
{"urlType":"pc_user_guide_url",
"remark":"用户指引1",
"id":7,
"url":"https://motapp.peopleyun.cn/embedded/pc/guide.html",
"checklogin":0,
"sid":"DEFAULT"
}' "http://10.0.0.11:8015/sys-server-config/sys/config/url/editUrlInterface"


#添加urltype
curl -H "Content-Type:application/json" -X POST --data '
{"urlType":"1",
"remark":"11",
"url":"11",
"checklogin":0,
"sid":"1"
}' "http://10.0.0.11:8015/sys-server-config/sys/config/url/addUrlInterface"

#删除urltype
curl "http://10.0.0.11:8015/sys-server-config/sys/config/url/deleteUrlInterfaceById?urlInterfaceId=12821"