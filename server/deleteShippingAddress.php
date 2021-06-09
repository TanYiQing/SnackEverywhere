<?php
error_reporting(0);
include_once("dbconnect.php");
$shipping_id = $_POST['shipping_id'];
$sqldelete = "DELETE FROM shipping_address WHERE shipping_id = '$shipping_id'";
    if ($conn->query($sqldelete) === TRUE){
       echo "Success";
    }else {
        echo "Failed";
    }
?>