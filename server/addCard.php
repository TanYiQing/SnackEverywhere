<?php
include_once("dbconnect.php");
$email=$_POST['email'];
$card_number=$_POST['card_number'];
$card_holder=$_POST['card_holder'];
$cvv=$_POST['cvv'];
$month=$_POST['month'];
$year=$_POST['year'];

$sqladdcard="INSERT INTO creditdebit_card(email, card_number, card_holder, cvv, month, year) VALUES('$email','$card_number','$card_holder','$cvv','$month','$year')";
if($conn->query($sqladdcard)===TRUE){
    echo "Success";
}else{
    echo "Failed";
}
?>