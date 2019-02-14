#------------------------【启用账号】------------------------
#在mysql，simba_DB里面执行搜索。
select * from aas_user_token a where a.user_number=66666955;
select * from aas_user_token_his a where a.user_number=66666955;
#以上如果执行结果为空，那么则执行以下的sql，修改状态。0是启动，1是禁用。
update aas_user_login a set state=0 where a.user_number=66666955;
#如果不为空，那么除了执行修改状态的sql，还需要更新redis。
#------------------------
#  中政委删除缓存key，在baseserver1
#------------------------
[root@baseserver1 ~]# ./redis-del-key.sh AAS:AUTHENTICATION:USERLOGIN:

#------------------------【禁用账号/账号注销】------------------------

curl -H "Content-Type:application/json" -X POST --data '{"userNumber": 65656565}' "http://172.16.39.62:8015/uic-server-user/uic/media/user/accountCancel"

/uic-server-user/uic/media/user/account/cancel