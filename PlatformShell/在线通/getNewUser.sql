select concat(a.user_number,',',a.nick_name,',',b.sid_code) into outfile '/var/lib/mysql-files/NewUser.txt'
from uic_user_info a,uic_sid_user b 
where FROM_UNIXTIME(a.create_time,'%Y%m%d')=DATE_FORMAT(now(),'%Y%m%d') and a.user_number=b.user_number and b.sid_code='RMZX_ZXT';