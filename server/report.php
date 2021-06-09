<?php
include_once("dbconnect.php");
$first_name=$_POST['first_name'];
$last_name=$_POST['last_name'];
$email=$_POST['email'];
$issue=$_POST['issue'];
$encoded_string=$_POST['encoded_string'];

$sqlreport="INSERT INTO reportIssue(first_name,last_name,email,issue) VALUES('$first_name','$last_name','$email','$issue')";
if($conn->query($sqlreport)===true){
    $decoded_string=base64_decode($encoded_string);
    $last_id = $conn->insert_id;
    //$filename=mysqli_insert_id($conn);
    $path= '../images/report_issue/'.$last_id.'.png';
    $is_written=file_put_contents($path,$decoded_string);
    echo "Success";
}else{
    echo "Failed";
}
?>