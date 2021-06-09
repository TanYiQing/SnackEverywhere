<?php
include_once("dbconnect.php");
$email=$_POST['email'];
$card_id=$_POST['card_id'];
$card_number=$_POST['card_number'];
$card_holder=$_POST['card_holder'];
$cvv=$_POST['cvv'];
$month=$_POST['month'];
$year=$_POST['year'];

$sqleditcard="UPDATE creditdebit_card SET card_id='$card_id',card_number='$card_number',card_holder='$card_holder',cvv='$cvv',month='$month',year='$year' WHERE email='$email' AND card_id='$card_id'";
if($conn->query($sqleditcard)===TRUE){
    echo "Success";
}else{
echo "Failed";
}
?>