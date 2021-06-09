<?php
include_once("dbconnect.php");
$email=$_POST['email'];
$billing_id=$_POST['billing_id'];
$b_name=$_POST['b_name'];
$b_phone=$_POST['b_phone'];
$b_address1=$_POST['b_address1'];
$b_address2=$_POST['b_address2'];
$b_address3=$_POST['b_address3'];
$b_zip=$_POST['b_zip'];
$b_city=$_POST['b_city'];
$b_state=$_POST['b_state'];

$sqleditbilling="UPDATE billing_address SET b_name='$b_name',b_phone='$b_phone',b_address1='$b_address1',b_address2='$b_address2',b_address3='$b_address3',b_zip='$b_zip',b_city='$b_city',b_state='$b_state' WHERE email='$email' AND billing_id='$billing_id'";
if($conn->query($sqleditbilling)===TRUE){
    echo "Success";
}else{
echo "Failed";
}
?>