<?php

include_once("dbconnect.php");
$first_name=$_POST['firstName'];
$last_name=$_POST['lastName'];
$email=$_POST['email'];
$feedback=$_POST['feedback'];

$sqlfeedback="INSERT INTO feedback(first_name,last_name,email,feedback) VALUES('$first_name','$last_name','$email','$feedback')";
if ($conn->query($sqlfeedback) === TRUE){
    echo "Success";
    
}else{
    echo "Failed";
}

?>