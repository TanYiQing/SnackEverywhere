<?php
error_reporting(0);
include_once("dbconnect.php");
$report_id = $_POST['report_id'];
$sqldelete = "DELETE FROM reportIssue WHERE report_id = '$report_id'";
    if ($conn->query($sqldelete) === TRUE){
       echo "Success";
    }else {
        echo "Failed";
    }
?>