#!/bin/bash
	
i=1
rm -rf contactuserweb.temp
\cp index_bak.html index.html
cat CreateSucAll.txt|while read line
do
  userNumber=`echo $line|cut -d ',' -f1`
	enterName=`echo $line|cut -d ',' -f2`
	#开始更新联系客服页面
  echo '<tr>
<td>'$enterName'</td>
<td>'$userNumber'</td><td><input type="button" onclick="cell('$i')" value="联系" /></td>
</tr>
'>>index.html

	i=$(($i+1))
	
done

#更新尾部html
echo '</table>
</div>

</body>
</html>'>>index.html

#发送到kangle服务端上
ftp -n << !
open 10.0.0.30 21
user upload Simba@aot888
bin
lcd /root/trial
put index.html
bye

!

exit 0

