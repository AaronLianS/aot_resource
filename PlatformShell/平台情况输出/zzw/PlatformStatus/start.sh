cd /workspace/webs/common/PlatformStatus
\cp zzw_bak.html zzw`date -d today +"%Y%m%d"`.html
curl "http://127.0.0.1:82/common/PlatformStatus/getplatforminfo.php">>zzw`date -d today +"%Y%m%d"`.html

