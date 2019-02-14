/*  
从simba库中复制uic_enterprise_buddy表至IMDB1的im_login库中,在im_login库中，执行下面的语句。
*/
select a.user_number,b.real_name,cust_info ,FROM_UNIXTIME(a.lgs_login_date_time),FROM_UNIXTIME(a.lgs_logout_date_time) 
from (
select * from cust_lgs_ims_reg
UNION
select * from cust_lgs_ims_reg_his) a LEFT JOIN   uic_enterprise_buddy b on a.user_number=b.user_number  where enterprise_id=700057
and FROM_UNIXTIME(a.lgs_login_date_time) between '20180817' and '20180823' 
and a.user_number not in(30001002,61000009,61000012,61000025,61000031,61000042,61000044,61000049,61000051,61000096,61000147,61003890,61004687,61000153,66509272,66092622,61004696,68136150)

select a.user_number,b.real_name,cust_info ,FROM_UNIXTIME(a.lgs_login_date_time),FROM_UNIXTIME(a.lgs_logout_date_time) 
from (
select * from cust_lgs_ims_reg
UNION
select * from cust_lgs_ims_reg_his) a LEFT JOIN   uic_enterprise_buddy b on a.user_number=b.user_number  where enterprise_id=700057
and FROM_UNIXTIME(a.lgs_login_date_time) between '20180720' and '20180726' 
and a.user_number not in(30001002,61000009,61000012,61000025,61000031,61000042,61000044,61000049,61000051,61000096,61000147,61003890,61004687,61000153,66509272,66092622,61004696,68136150)
order by FROM_UNIXTIME(a.lgs_login_date_time) desc