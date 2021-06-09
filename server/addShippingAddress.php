<?php
include_once("dbconnect.php");
$email=$_POST['email'];
$s_name=$_POST['s_name'];
$s_phone=$_POST['s_phone'];
$s_address1=$_POST['s_address1'];
$s_address2=$_POST['s_address2'];
$s_address3=$_POST['s_address3'];
$s_zip=$_POST['s_zip'];
$s_city=$_POST['s_city'];
$s_state=$_POST['s_state'];

$sqladdshipping = "INSERT INTO shipping_address(email,s_name,s_phone,s_address1,s_address2,s_address3,s_zip,s_city,s_state) VALUES('$email','$s_name','$s_phone','$s_address1','$s_address2','$s_address3','$s_zip','$s_city','$s_state')";
if ($conn->query($sqladdshipping) === TRUE){
    echo "Success";
}else{
    echo "Failed";
}

?>