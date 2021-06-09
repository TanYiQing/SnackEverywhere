<?php
error_reporting(0);
include_once("dbconnect.php");
$product_id = $_POST['product_id'];
$sqldelete = "DELETE FROM product WHERE product_id = '$product_id'";
    if ($conn->query($sqldelete) === TRUE){
       echo "Success";
    }else {
        echo "Failed";
    }
?>