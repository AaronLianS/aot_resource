#AppCodes集合，每一个都代表一个应用，code对应的应用，在op_app_info里面。
Basica0ezsqwnlthktkmyTg70Gi 任务流
Basica0ezsrfn1ypsoqpcb8R549	电话会议
Basica0ezz4vvx7yg9r08F3m1py	工作流
Basica0ezz4yk69gwzhekfc7C7c	通知公告
Basica0f142oz7qwofy0o219448	商务电话
Basica0f142q3iu3s7ir27olyrl	新闻资讯
Basica0f142qw7nfkuaid66t816	问题反馈
Basica0f142rgw5wgh9fe23wN67	视频会议
Basica0f14397i40opstcD5yH79	我的文件
Basica0f41xy7qs34e8sv286e83 众云


#这是设置【sid】自定义基础应用接口例子
curl -H "Content-Type:application/json" -X POST --data '{"sidCode":"RMZX_ZXT","appCodes":["Basica0ezsqwnlthktkmyTg70Gi","Basica0ezz4vvx7yg9r08F3m1py","Basica0ezz4yk69gwzhekfc7C7c","Basica0f142oz7qwofy0o219448","Basica0ezsrfn1ypsoqpcb8R549","Basica0f142rgw5wgh9fe23wN67"]}' "http://10.0.0.11:8015/operation-server-basic/operation/basicApp/setSidCustom"

curl -H "Content-Type:application/json" -X POST --data '{"sidCode":"RMZX_YQT","appCodes":["Basica0ezz4yk69gwzhekfc7C7c","Basica0f142oz7qwofy0o219448","Basica0f41xy7qs34e8sv286e83"]}' "http://10.0.0.11:8015/operation-server-basic/operation/basicApp/setSidCustom"

#这是设置【组织】自定义基础应用接口例子
curl -H "Content-Type:application/json" -X POST --data '{"enterpriseId":"235984","appCodes":["Basica0ezsqwnlthktkmyTg70Gi","Basica0ezz4vvx7yg9r08F3m1py","Basica0ezz4yk69gwzhekfc7C7c","Basica0f142oz7qwofy0o219448","Basica0ezsrfn1ypsoqpcb8R549"]}' "http://10.0.0.11:8015/operation-server-basic/operation/basicApp/setEnterCustom"

#人民通
curl -H "Content-Type:application/json" -X POST --data '{"enterpriseId":"242265","appCodes":["Basica0ezz4yk69gwzhekfc7C7c","Basica0f142oz7qwofy0o219448","Basica0f41xy7qs34e8sv286e83","Basica0f142rgw5wgh9fe23wN67"]}' "http://10.0.0.11:8015/operation-server-basic/operation/basicApp/setEnterCustom"


#--新增应用------
curl -H "Content-Type:application/json" -X POST --data '{
"appName":"众云",
"appPcUrl":"http://zy.peopleyun.cn/zxt/index.do",
"appMobileUrl":"",
"imageUrl":"https://app.peopleyun.cn/embeddedZxt/module/imgs/rmwzy.png",
"appSynopsis":"领先的智能化舆情监测平台",
"appDesc":"众云个人"
}' "http://10.0.0.11:8015/operation-server-basic/operation/basicApp/addInfo"

手动添加的话
是否是默认应用 default_flag =0
1代表所有平台都可见

app_status=1
0是启动
1是禁用

user_default_flag=0
无组织状态是否显示
1代表显示

can_view_scope=1
1代表可设置
是否可以配置可视权限

can_close_flag=1
1代表可以关闭
是否可以关闭

#以上实际修改的时候，去掉_

#--编辑应用------
curl -H "Content-Type:application/json" -X POST --data '{
"appCode": "Basica0f41xy7qs34e8sv286e83",
"appPcUrl": "https://motapp.peopleyun.cn/conference/new/immediate.html?token=#TOKEN&enterId=#ENTERID&sid=#SID"
}' "http://10.0.0.11:8015/operation-server-basic/operation/basicApp/editInfo"


curl -H "Content-Type:application/json" -X POST --data '{
"appCode": "Basica0f142rgw5wgh9fe23wN67",
"appName": "视频会议",
"appPcUrl": "http://120.131.11.11:9037/pc/?sid=#SID&enterId=#ENTERID",
"appMobileUrl": "http://120.131.11.11:9037/mobile/H581ED50A.zip?appId=H581ED50A&version=1.1.22&md5=123"
}' "http://10.0.0.11:8015/operation-server-basic/operation/basicApp/editInfo"


#--启动应用------
curl http://10.0.0.11:8015/operation-server-basic/operation/basicApp/setEnable?appCode=Basica0ezsrfn1ypsoqpcb8R549











#---------------------------______________________________

curl -H "Content-Type:application/json" -X POST --data '{
"appCode": "Basica0f41xy7qs34e8sv286e83",
"appName": "众云大数据",
"appPcUrl": "http://zy.peopleyun.cn/yqt/index.do",
"appMobileUrl": "",
"imageUrl":"rmwzy.png",
"appSynopsis":"领先的智能化舆情监测平台",
"appDesc":"众云企业"
}' "http://10.0.0.11:8015/operation-server-basic/operation/basicApp/editInfo"