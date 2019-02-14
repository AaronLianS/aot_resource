
#http://base1.simba.pro:8015/aas-server-authority/aas/authority/departmentProperty/getUserViewTreeByEnterpriseIdAndUserNumber?userNumber=70036865&enterpriseId=547446

# wget http://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
# rpm -ivh epel-release-latest-7.noarch.rpm
# yum repolist
# yum -y install jq
userNumber=66329570
enterpriseId=235923

curl "http://baseserver1:8015/aas-server-authority/aas/authority/departmentProperty/getUserViewTreeByEnterpriseIdAndUserNumber?userNumber=$userNumber&enterpriseId=$enterpriseId">ent.json

rm -rf deptFullPath.txt

for((i=0;i<=500;i++));  
do
result=`jq ".result.depts[$i]|{deptId:.deptId, deptName:.deptName, depts:.depts }" ent.json`
deptId=`echo $result|jq '.deptId'|sed 's/\"//g'`
deptName=`echo $result|jq '.deptName'|sed 's/\"//g'`

  if [ "$deptId" = "null" ];then
    break  
  fi

echo "$deptId,$deptName;">>deptFullPath.txt
leavel1=`echo $result|jq '.depts'`

#echo $leavel1
 #-------------------------【2】-------------------- 
if [ "$leavel1" != "null" ];then
 for((j=0;j<=500;j++)); 
 do
  result2=`echo $result|jq ".depts[$j]|{deptId:.deptId, deptName:.deptName, depts:.depts }"`
  deptId2=`echo $result2|jq '.deptId'|sed 's/\"//g'`
  deptName2=`echo $result2|jq '.deptName'|sed 's/\"//g'`
  
  leavel2=`echo $result2|jq '.depts'`

  if [ "$deptId2" = "null" ];then
    break  
  fi
  
 #-------------------------【3】-------------------- 
if [ "$leavel2" != "null" ];then
 for((k=0;k<=500;k++)); 
 do
  result3=`echo $result2|jq ".depts[$k]|{deptId:.deptId, deptName:.deptName, depts:.depts }"`
  deptId3=`echo $result3|jq '.deptId'|sed 's/\"//g'`
  deptName3=`echo $result3|jq '.deptName'|sed 's/\"//g'`
  
  leavel3=`echo $result3|jq '.depts'`

  if [ "$deptId3" = "null" ];then
    break  
  fi
  
#-------------------------【4】-------------------- 
if [ "$leavel3" != "null" ];then
 for((l=0;l<=500;l++)); 
 do
  result4=`echo $result3|jq ".depts[$l]|{deptId:.deptId, deptName:.deptName, depts:.depts }"`
  deptId4=`echo $result4|jq '.deptId'|sed 's/\"//g'`
  deptName4=`echo $result4|jq '.deptName'|sed 's/\"//g'`
  
  leavel4=`echo $result4|jq '.depts'`

  if [ "$deptId4" = "null" ];then
    break  
  fi
  
  #-------------------------【5】-------------------- 
if [ "$leavel4" != "null" ];then
 for((p=0;p<=500;p++)); 
 do
  result5=`echo $result4|jq ".depts[$p]|{deptId:.deptId, deptName:.deptName, depts:.depts }"`
  deptId5=`echo $result5|jq '.deptId'|sed 's/\"//g'`
  deptName5=`echo $result5|jq '.deptName'|sed 's/\"//g'`
  
  leavel5=`echo $result5|jq '.depts'`

  if [ "$deptId5" = "null" ];then
    break  
  fi
  
  if [ "$leavel5" = "null" ];then
    continue  
  fi
  
  
  echo "$deptId5,$deptName-$deptName2-$deptName3-$deptName4-$deptName5;">>deptFullPath.txt

 done
 
fi
#-------------------------【5】--------------------
  
  echo "$deptId4,$deptName-$deptName2-$deptName3-$deptName4;">>deptFullPath.txt

 done
 
fi
#-------------------------【4】--------------------
  
  echo "$deptId3,$deptName-$deptName2-$deptName3;">>deptFullPath.txt

 done
 
fi
#-------------------------【3】--------------------
  
  echo "$deptId2,$deptName-$deptName2;">>deptFullPath.txt

 done
 
fi
 #-------------------------【2】-------------------- 


done
#

