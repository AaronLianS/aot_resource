#!/bin/bash
Type=$1

if [ "$Type" = "1" ];then

curl -H "Content-Type:application/json" -X POST --data '{
	"bizTypeCode":"notice",
	"templateCode":"notice_general",
	"businessId":"99997",
	"subject":"上班打卡",
	"summary":null,
	"content":"打卡打卡打卡打卡",
	"enterId":null,
	"enterName":null,
	"imageUrl":null,
	"attachNum":0,
	"feedbackFlag":null,
	"version":null,
	"sender":10000,
	"receivers":[66120270],
	"form":null,
	"multiContent":null,
	"rich":null}' "http://base1.simba.pro:8015/nc-server-business/nc/business/sendBusinessNotice"

fi

if [ "$Type" = "2" ];then

curl -H "Content-Type:application/json" -X POST --data '{
	"bizTypeCode":"notice",
	"templateCode":"notice_general",
	"businessId":"99997",
	"subject":"中午打卡",
	"summary":null,
	"content":"打卡打卡打卡打卡",
	"enterId":null,
	"enterName":null,
	"imageUrl":null,
	"attachNum":0,
	"feedbackFlag":null,
	"version":null,
	"sender":10000,
	"receivers":[66120270],
	"form":null,
	"multiContent":null,
	"rich":null}' "http://base1.simba.pro:8015/nc-server-business/nc/business/sendBusinessNotice"

fi

if [ "$Type" = "3" ];then

curl -H "Content-Type:application/json" -X POST --data '{
	"bizTypeCode":"notice",
	"templateCode":"notice_general",
	"businessId":"99997",
	"subject":"下班打卡",
	"summary":null,
	"content":"打卡打卡打卡打卡",
	"enterId":null,
	"enterName":null,
	"imageUrl":null,
	"attachNum":0,
	"feedbackFlag":null,
	"version":null,
	"sender":10000,
	"receivers":[66120270],
	"form":null,
	"multiContent":null,
	"rich":null}' "http://base1.simba.pro:8015/nc-server-business/nc/business/sendBusinessNotice"

fi





