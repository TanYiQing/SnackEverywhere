<?php
include_once("dbconnect.php");
$email=$_POST['email'];
$b_name=$_POST['b_name'];
$b_phone=$_POST['b_phone'];
$b_address1=$_POST['b_address1'];
$b_address2=$_POST['b_address2'];
$b_address3=$_POST['b_address3'];
$b_zip=$_POST['b_zip'];
$b_city=$_POST['b_city'];
$b_state=$_POST['b_state'];

$sqladdbilling = "INSERT INTO billing_address(email,b_name,b_phone,b_address1,b_address2,b_address3,b_zip,b_city,b_state) VALUES('$email','$b_name','$b_phone','$b_address1','$b_address2','$b_address3','$b_zip','$b_city','$b_state')";
if ($conn->query($sqladdbilling) === TRUE){
    echo "Success";
}else{
    echo "Failed";
}

?>

