--IM日活
--见boss



---------------------------------------------------------------IM聊天记录---------------------------------------------------------------

--首次建立视图，只需要建立一次
create or replace view chatcount
as

select send_id,serv_ts  from im_priv_message0
union
select send_id,serv_ts  from im_priv_message1
union
select send_id,serv_ts  from im_priv_message2
union
select send_id,serv_ts  from im_priv_message3
union
select send_id,serv_ts  from im_priv_message4
union
select send_id,serv_ts  from im_priv_message5
union
select send_id,serv_ts  from im_priv_message6
union
select send_id,serv_ts  from im_priv_message7
union
select send_id,serv_ts  from im_priv_message8
union
select send_id,serv_ts  from im_priv_message9
union
select send_id,serv_ts  from im_priv_message10
union
select send_id,serv_ts  from im_priv_message11
union
select send_id,serv_ts  from im_priv_message12
union
select send_id,serv_ts  from im_priv_message13
union
select send_id,serv_ts  from im_priv_message14
union
select send_id,serv_ts  from im_priv_message15
union
select send_id,serv_ts  from im_priv_message16
union
select send_id,serv_ts  from im_priv_message17
union
select send_id,serv_ts  from im_priv_message18
union
select send_id,serv_ts  from im_priv_message19
union
select send_id,serv_ts  from im_priv_message20
union
select send_id,serv_ts  from im_priv_message21
union
select send_id,serv_ts  from im_priv_message22
union
select send_id,serv_ts  from im_priv_message23
union
select send_id,serv_ts  from im_priv_message24
union
select send_id,serv_ts  from im_priv_message25
union
select send_id,serv_ts  from im_priv_message26
union
select send_id,serv_ts  from im_priv_message27
union
select send_id,serv_ts  from im_priv_message28
union
select send_id,serv_ts  from im_priv_message29
union
select send_id,serv_ts  from im_priv_message30
union
select send_id,serv_ts  from im_priv_message31

union
select send_id,serv_ts  from im_group_message0
union
select send_id,serv_ts  from im_group_message1
union
select send_id,serv_ts  from im_group_message2
union
select send_id,serv_ts  from im_group_message3
union
select send_id,serv_ts  from im_group_message4
union
select send_id,serv_ts  from im_group_message5
union
select send_id,serv_ts  from im_group_message6
union
select send_id,serv_ts  from im_group_message7
union
select send_id,serv_ts  from im_group_message8
union
select send_id,serv_ts  from im_group_message9
union
select send_id,serv_ts  from im_group_message10
union
select send_id,serv_ts  from im_group_message11
union
select send_id,serv_ts  from im_group_message12
union
select send_id,serv_ts  from im_group_message13
union
select send_id,serv_ts  from im_group_message14
union
select send_id,serv_ts  from im_group_message15
union
select send_id,serv_ts  from im_group_message16
union
select send_id,serv_ts  from im_group_message17
union
select send_id,serv_ts  from im_group_message18
union
select send_id,serv_ts  from im_group_message19
union
select send_id,serv_ts  from im_group_message20
union
select send_id,serv_ts  from im_group_message21
union
select send_id,serv_ts  from im_group_message22
union
select send_id,serv_ts  from im_group_message23
union
select send_id,serv_ts  from im_group_message24
union
select send_id,serv_ts  from im_group_message25
union
select send_id,serv_ts  from im_group_message26
union
select send_id,serv_ts  from im_group_message27
union
select send_id,serv_ts  from im_group_message28
union
select send_id,serv_ts  from im_group_message29
union
select send_id,serv_ts  from im_group_message30
union
select send_id,serv_ts  from im_group_message31
where send_id <>'10000' or '10001'

--日常查询使用
select count(1)/5 from chatcount
where FROM_UNIXTIME(SUBSTRING(serv_ts,1,10))  between '20180720' and '20180726' 



--------------------------------------------------------------- 总用户数--------------------------------------------------------------
--所有有组织人员
select count(1) from uic_enterprise_buddy
--所有人员，包含无组织成员
select count(1) from uic_user_info
--无组织人员
select count(1) from uic_user_info where user_number not in (select user_number from uic_enterprise_buddy)



-------------------------------------------------------------- 业务系统--------------------------------------------------------------
/*---------------通过公告--------------*/
/*时间段数据*/
select count(*) from bc_notice_info
where DATE_FORMAT(created_time,'%Y%m%d') between '20171116' and '20171122'


/*---------------任务管理--------------*/
/*时间段数据*/
select count(*) from tb_task_info
where DATE_FORMAT(created_time,'%Y%m%d') between '20171116' and '20171122'


/*---------------工作流--------------*/
/*时间段数据*/
select count(*) from wf_examine_approve_tbl
where DATE_FORMAT(wf_crtime,'%Y%m%d') between '20171116' and '20171122'








/*---------------同事圈---------------*/
/*时间段每天按类型出数据*/
select FROM_UNIXTIME(a.publish_time,'%Y%m%d') 日期, 
case a.type when 'post' then '文字' when 'repost' then '转发' when 'shareurl' then '分享链接' when 'postimage' then '图文' when 'postvideo' then '视频' end 类型, 
count(a.feed_id) 次数
from ts_feed a
where FROM_UNIXTIME(a.publish_time,'%Y%m%d') between '20171116' and '20171122' and is_del =0 
group by FROM_UNIXTIME(a.publish_time,'%Y%m%d'),a.type


/*时间段总数据*/
select count(a.feed_id) 次数
from ts_feed a
where FROM_UNIXTIME(a.publish_time,'%Y%m%d') between '20171116' and '20171122' and is_del =0 


/*时间段按类型数据*/
select  
case a.type when 'post' then '文字' when 'repost' then '转发' when 'shareurl' then '分享链接' when 'postimage' then '图文' when 'postvideo' then '视频' end 类型, 
count(a.feed_id) 次数
from ts_feed a
where FROM_UNIXTIME(a.publish_time,'%Y%m%d') between '20171116' and '20171122' and is_del =0 
group by a.type

