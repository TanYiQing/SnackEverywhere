<?php
error_reporting(0);
include_once("dbconnect.php");
$feedback_id = $_POST['feedback_id'];
$sqldelete = "DELETE FROM feedback WHERE feedback_id = '$feedback_id'";
    if ($conn->query($sqldelete) === TRUE){
       echo "Success";
    }else {
        echo "Failed";
    }
?>