<?php
include_once("dbconnect.php");

$email=$_POST['email'];
$receiptid=$_POST['receiptid'];
$status=$_POST['status'];

$sqlupdatestatus="UPDATE tbl_order SET status='$status' WHERE email='$email' AND receipt_id='$receiptid'";

if($conn->query($sqlupdatestatus)===TRUE){
    echo "Success";
}else{
echo "Failed";
}
?>