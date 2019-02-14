#------------------------【更改人员绑定手机号或邮箱（绑定and解绑）】------------------------
#绑定
curl -d "account=18018887731&userNumber=66126893" "http://10.0.0.11:8015/uic-server-user/uic/media/user/accountBinding"
#移除
curl -d "account=18117255685&userNumber=66539559" "http://10.0.0.11:8015/uic-server-user/uic/media/user/removeBinding"