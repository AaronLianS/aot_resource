ftp -n << !
open 10.0.0.30 21
user upload Simba@aot888
bin
lcd /root/trial
put index.html
bye

!

exit 0
