说明：
mysql主库上执行
node1.simba.pro 这个是每个环境都不一样
样本
curl -H "Content-Type:application/json" -X POST --data ' {"userNumber":1,"groupNumber":1}' "http://node1.simba.pro:8015/uic-server-group/uic/group/quitGroup"
以下为脚本内容和执行步骤

rm -rf /var/lib/mysql-files/a.sh
mysql -u root -pwww.simba.pro simba_db1

select concat('curl -H "Content-Type:application/json" -X POST --data ','''',' {"userNumber":',user_number,',','"groupNumber":',group_number,'}','''',' "http://10.0.0.11:8015/uic-server-group/uic/group/quitGroup"')
 into outfile '/var/lib/mysql-files/a.sh' from uic_group_member   
  where user_number=66839677 and  group_number in(select group_number from uic_group_info 
  where create_time <= unix_timestamp('20180401') and group_type=0 and name like '%,%' )
  limit 2000;
exit;  
chmod +x /var/lib/mysql-files/a.sh
/var/lib/mysql-files/a.sh



select user_number,group_number from uic_group_member   
  where user_number=66839677 and  group_number in(select group_number from uic_group_info 
  where create_time <= unix_timestamp('20180601') and group_type=0 and name like '%,%' ) limit 2000;
  
  
  
  
  
rm -rf /var/lib/mysql-files/a.sh
mysql -u root -pwww.simba.pro simba_db1

select concat('curl -H "Content-Type:application/json" -X POST --data ','''',' {"userNumber":',user_number,',','"groupNumber":',group_number,'}','''',' "http://10.0.0.11:8015/uic-server-group/uic/group/quitGroup"')
 into outfile '/var/lib/mysql-files/a.sh' from uic_group_member   
  where user_number=66839677 and  group_number in(select group_number from uic_group_info 
  where group_type=0)
  limit 2000;
exit;  
chmod +x /var/lib/mysql-files/a.sh
/var/lib/mysql-files/a.sh