<?php
error_reporting(0);
include_once("dbconnect.php");
$email = $_POST['email'];
$password = sha1($_POST['password']);

if (isset($email)){
    $sqllogin= "SELECT * FROM tbl_user WHERE email = '$email'";
}
else{
    $sqllogin = "SELECT * FROM tbl_user WHERE email = '$email' AND password = '$password' AND otp = '0'";
}

$result = $conn->query($sqllogin);

if ($result->num_rows > 0) {
    while ($row = $result ->fetch_assoc()){
        echo $data = "Success#".$row["first_name"]."#".$row["last_name"]."#".$row["email"]."#".$row["date_register"]."#".$row["c_qty"];
    }
}

else{
    echo "Failed";
}

?>