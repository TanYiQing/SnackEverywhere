<?php
error_reporting(0);
include_once("dbconnect.php");
$email = $_POST['email'];
$product_id = $_POST['product_id'];
$sqldelete = "DELETE FROM cart WHERE email='$email' AND product_id = '$product_id'";
    if ($conn->query($sqldelete) === TRUE){
       echo "Success";
    }else {
        echo "Failed";
    }
?>