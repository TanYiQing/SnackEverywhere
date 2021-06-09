<?php
error_reporting(0);
include_once("dbconnect.php");
$card_id = $_POST['card_id'];
$sqldelete = "DELETE FROM creditdebit_card WHERE card_id = '$card_id'";
    if ($conn->query($sqldelete) === TRUE){
       echo "Success";
    }else {
        echo "Failed";
    }
?>