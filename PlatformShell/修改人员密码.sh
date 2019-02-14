#------------------------【修改人员密码】------------------------
curl -H "Content-Type:application/json" -X POST --data '{
"userNumber":66126893,
"newPwd":"888888"}' "http://10.0.0.11:8015/uic-server-user/uic/media/user/pwd/reset"

#------------------------【批量修改人员密码】------------------------

changepasswdinfo=changepasswdinfo.txt
changepasswdinfoResultFile=changepasswdinfo_`date -d today +"%Y%m%d%H%M%S"`
password=888888

cat $changepasswdinfo | while read line
do

userID=`echo $line|cut -d ',' -f1`
temp=`curl -H "Content-Type:application/json" -X POST --data '{
"userNumber":'$userID',
"newPwd":"'$password'"}' "http://10.0.0.11:8015/uic-server-user/uic/media/user/pwd/reset"`
echo $temp>>/tmp/$changepasswdinfoResultFile.txt

done

