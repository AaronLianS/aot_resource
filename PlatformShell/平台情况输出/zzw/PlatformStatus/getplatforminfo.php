
<?php
ini_set('max_execution_time','1000');
header("Content-type: text/html; charset=utf-8");
echo "时间：" . date("Y-m-d",strtotime("-5 day")) . "----" . date("Y-m-d",strtotime("-1 DAY")). "，共5天。<br>";


//------------------获取每日在线-------------------
$servername = "172.16.39.64";
$username = "u_im_login";
$password = "kkjjimmeee20099_0591";
$dbname = "im_login";


// 创建连接
$conn = new mysqli($servername, $username, $password, $dbname);
// Check connection
if ($conn->connect_error) {
    die("连接失败: " . $conn->connect_error);
} 
 
$sql = "select count(*)/5 onlineavg from m_stat_online where sdate >= DATE_FORMAT(DATE_SUB(curdate(),INTERVAL 5 DAY),'%Y%m%d') and edate <= DATE_FORMAT(DATE_SUB(curdate(),INTERVAL 1 DAY),'%Y%m%d');";
$result = $conn->query($sql);

if ($result->num_rows > 0) {
    // 输出数据
    while($row = $result->fetch_assoc()) {
        $sqlresult ="每日平均在线：". $row["onlineavg"] . "<br>";
		echo $sqlresult;

    }
}
$conn->close();



//

$servername = "172.16.39.37";
$username = "u_im";
$password = "lkqweru8987_098j";
$dbname = "im";


// 创建连接
$conn = new mysqli($servername, $username, $password, $dbname);
// Check connection
if ($conn->connect_error) {
    die("连接失败: " . $conn->connect_error);
} 
 
$sql = "select value imavg from weeklychatsum where date=DATE_FORMAT(DATE_SUB(curdate(),INTERVAL 0 DAY),'%Y%m%d');";
//select count(1)/5 imavg from chatcount where FROM_UNIXTIME(SUBSTRING(serv_ts,1,10))  between DATE_FORMAT(DATE_SUB(curdate(),INTERVAL 5 DAY),'%Y%m%d') and DATE_FORMAT(DATE_SUB(curdate(),INTERVAL 1 DAY),'%Y%m%d');
$result = $conn->query($sql);

if ($result->num_rows > 0) {
    // 输出数据
    while($row = $result->fetch_assoc()) {
        $sqlresult ="每日平均IM数据：". $row["imavg"] . "<br>";
		echo $sqlresult;

    }
}
$conn->close();






//----------------------人员数据---------------
$servername = "172.16.39.70";
$username = "root";
$password = "adkfinh07juyhlhy09";
$dbname = "simba";


// 创建连接
$conn = new mysqli($servername, $username, $password, $dbname,8066);
// Check connection
if ($conn->connect_error) {
    die("连接失败: " . $conn->connect_error);
} 
 
 
$sql = "select count(1) enteruser from uic_enterprise_buddy";
$result = $conn->query($sql);

if ($result->num_rows > 0) {
    // 输出数据
    while($row = $result->fetch_assoc()) {
        $sqlresult ="有组织的用户总数：" . $row["enteruser"] . "<br>";
		echo $sqlresult;

    }
}
 
 
 
$sql = "select count(1) noenteruser from uic_user_info where user_number not in (select user_number from uic_enterprise_buddy)";
$result = $conn->query($sql);

if ($result->num_rows > 0) {
    // 输出数据
    while($row = $result->fetch_assoc()) {
        $sqlresult ="无组织的用户总数：" . $row["noenteruser"] . "<br>";
		echo $sqlresult;

    }
}

$conn->close();


//----------------------同事圈---------------
$servername = "172.16.39.69";
$username = "u_workmategroup";
$password = "wqerwerjjliyyttu0591";
$dbname = "workmategroup";


// 创建连接
$conn = new mysqli($servername, $username, $password, $dbname);
// Check connection
if ($conn->connect_error) {
    die("连接失败: " . $conn->connect_error);
} 
 
$sql = "select count(a.feed_id) workmatecount from ts_feed a where FROM_UNIXTIME(a.publish_time,'%Y%m%d') between DATE_FORMAT(DATE_SUB(curdate(),INTERVAL 5 DAY),'%Y%m%d') and DATE_FORMAT(DATE_SUB(curdate(),INTERVAL 1 DAY),'%Y%m%d')and is_del =0;";
$result = $conn->query($sql);

if ($result->num_rows > 0) {
    // 输出数据
    while($row = $result->fetch_assoc()) {
        $sqlresult ="同事圈数据：". $row["workmatecount"] . "<br>";
		echo $sqlresult;

    }
}
$conn->close();


?>

</li>
		

		</ul>
	</div>
	
</div>
</div>
	
</body>
</html>

