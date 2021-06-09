<?php

include_once("dbconnect.php");

    $email=$_POST['email'];
    $firstname=$_POST['firstname'];
    $lastname=$_POST['lastname'];
    
    $sqlvalidation= "SELECT * FROM tbl_user WHERE email='$email'";
    $result = $conn->query($sqlvalidation);
    if ($result->num_rows > 0){
        $sqlupdate = "UPDATE tbl_user SET first_name = '$firstname', last_name='$lastname' WHERE email = '$email'";
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