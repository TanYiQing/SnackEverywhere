<?php

include_once("dbconnect.php");

    $email=$_POST['email'];
   
    $oldpassword=$_POST['oldpassword'];
    $oldpasswordsha=sha1($oldpassword);
    $newpassword=$_POST['newpassword'];
    $newpasswordsha=sha1($newpassword);
    
    
    $sqlvalidation= "SELECT * FROM tbl_user WHERE email='$email' AND password='$oldpasswordsha'";
    $result = $conn->query($sqlvalidation);
    if ($result->num_rows > 0){
        $sqlupdate = "UPDATE tbl_user SET password = '$newpasswordsha' WHERE email = '$email' AND password='$oldpasswordsha'";
        if($conn->query($sqlupdate)===TRUE){
        echo 'Success';
        }
        else{
        echo 'Failed';
        }
    }else{
        echo 'Failed';
    }
    
?>