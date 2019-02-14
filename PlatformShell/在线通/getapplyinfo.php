<?php
header("Content-type: text/html; charset=utf-8");

$servername = "localhost";
$username = "root";
$password = "Simba@aot888";
$dbname = "limesurvey";

 echo "用户ID,单位名称,联系人,联系电话\n";
// 创建连接
$conn = new mysqli($servername, $username, $password, $dbname);
// Check connection
if ($conn->connect_error) {
    die("连接失败: " . $conn->connect_error);
} 
 
$sql = "select * from lime_survey_382362 where submitdate is not null and DATE_FORMAT(submitdate,'%Y%m%d') = DATE_FORMAT(NOW(),'%Y%m%d') and 382362X1X11 != '' order by id desc";
$result = $conn->query($sql);
 
if ($result->num_rows > 0) {
    // 输出数据
    while($row = $result->fetch_assoc()) {
        $sqlresult = $row["382362X1X11"]. "," . $row["382362X1X1SQ001"]. "," . $row["382362X1X1SQ003"] . "," . $row["382362X1X1SQ004"] . "\n";
		echo $sqlresult;

    }
} else {
    echo "0 结果";
}
$conn->close();


?>