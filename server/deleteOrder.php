<?php
error_reporting(0);
include_once("dbconnect.php");
$receipt_id = $_POST['receipt_id'];
$order_id=$_POST['order_id'];
$sqldelete = "DELETE FROM tbl_order WHERE receipt_id = '$receipt_id' AND order_id='$order_id'";
    if ($conn->query($sqldelete) === TRUE){
       echo "Success";
    }else {
        echo "Failed";
    }
?>