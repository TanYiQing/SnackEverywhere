<?php
include_once("dbconnect.php");
$email=$_POST['email'];
$shipping_id=$_POST['shipping_id'];
$s_name=$_POST['s_name'];
$s_phone=$_POST['s_phone'];
$s_address1=$_POST['s_address1'];
$s_address2=$_POST['s_address2'];
$s_address3=$_POST['s_address3'];
$s_zip=$_POST['s_zip'];
$s_city=$_POST['s_city'];
$s_state=$_POST['s_state'];

$sqleditshipping="UPDATE shipping_address SET s_name='$s_name',s_phone='$s_phone',s_address1='$s_address1',s_address2='$s_address2',s_address3='$s_address3',s_zip='$s_zip',s_city='$s_city',s_state='$s_state' WHERE email='$email' AND shipping_id='$shipping_id'";
if($conn->query($sqleditshipping)===TRUE){
    echo "Success";
}else{
echo "Failed";
}
?>