<?php
error_reporting(0);
include_once("dbconnect.php");
$billing_id = $_POST['billing_id'];
$sqldelete = "DELETE FROM billing_address WHERE billing_id = '$billing_id'";
    if ($conn->query($sqldelete) === TRUE){
       echo "Success";
    }else {
        echo "Failed";
    }
?>