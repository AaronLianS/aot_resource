
0 5 * * 6 sh /workspace/webs/common/PlatformStatus/start.sh
http://219.142.142.163:82/common/PlatformStatus/getplatforminfo.php
http://219.142.142.163:82/common/PlatformStatus/zzw20190102.html

im聊天记录,预先保存存到其他表上
-- ----------------------------
-- Table structure for `weeklychatsum`
-- ----------------------------
DROP TABLE IF EXISTS `weeklychatsum`;
CREATE TABLE `weeklychatsum` (
  `date` date NOT NULL,
  `value` bigint(30) DEFAULT NULL,
  PRIMARY KEY (`date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- PROCEDURE structure for `updateweeklychatsum`
-- ----------------------------
CREATE PROCEDURE `updateweeklychatsum`()
BEGIN
	select DATE_FORMAT(DATE_SUB(curdate(),INTERVAL 0 DAY),'%Y%m%d') into @nowdate;
	select count(1)/5 chatcount into @imavg from im_group_message15 where FROM_UNIXTIME(SUBSTRING(serv_ts,1,10))  
	between DATE_FORMAT(DATE_SUB(curdate(),INTERVAL 5 DAY),'%Y%m%d') and DATE_FORMAT(DATE_SUB(curdate(),INTERVAL 1 DAY),'%Y%m%d');
	delete from weeklychatsum where date=DATE_FORMAT(DATE_SUB(curdate(),INTERVAL 0 DAY),'%Y%m%d');
 INSERT INTO weeklychatsum(date,value) select @nowdate,@imavg  ;
END

#在crontab里面,定时执行.
0 4 * * 6 mysql -u root -pwww.simba.pro im -e "call updateweeklychatsum();"



#在simba服务器上，创建业务通知。
busid=`date -d today +"%Y%m%d"`
#busid=`date -d today +"%Y%m%d%H%M%S"`

curl -H "Content-Type:application/json" -X POST --data '{
"bizTypeCode":"notice",
"templateCode":"notice_general",
"businessId":"zzwplatform'$busid'",
"subject":"中政委平台情况",
"summary":null,
"content":"'`date -d today +"%Y-%m-%d"`'中政委上周平台情况",
"enterId":null,
"enterName":null,
"imageUrl":null,
"attachNum":0,
"feedbackFlag":null,
"linkUrl":"http://219.142.142.163:82/common/PlatformStatus/zzw'`date -d "2 days ago" +"%Y%m%d"`'.html",
"pointLink":"http://219.142.142.163:82/common/PlatformStatus/zzw'`date -d "2 days ago" +"%Y%m%d"`'.html",
"version":null,
"sender":10000,
"receivers":[66120270,66786996],
"form":null,
"multiContent":null,
"rich":null}' "http://base1.simba.pro:8015/nc-server-business/nc/business/sendBusinessNotice"

0 9 * * 1 sh /root/lz/zzwplatformnotice.sh

	
	
	
	
	
	
	