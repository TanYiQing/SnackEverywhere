<?php
include_once("dbconnect.php");
$email=$_POST['email'];
$collect_option=$_POST['collect_option'];
$collect_date=$_POST['collect_date'];
$payment_option=$_POST['payment_option'];
$status="Order Received";
$address=$_POST['address'];

$sqltransfer="INSERT INTO tbl_order(email,product_id,product_size,product_price,o_quantity) SELECT email,product_id,product_size,product_price,c_quantity FROM cart WHERE email='$email'";
if($conn->query($sqltransfer)===true){
    $sqlpublish="UPDATE tbl_order SET collect_option='$collect_option', collect_date='$collect_date', payment_option='$payment_option', status='$status', address='$address' WHERE date_order=(SELECT MAX(date_order) FROM tbl_order) AND email='$email'";
    if($conn->query($sqlpublish)===true){
        $sqlclearcart="DELETE FROM cart WHERE email='$email'";
        if($conn->query($sqlclearcart)===true){
             echo "S";
        }
    }else{
        echo "Failed";
    }
    
}else{
    echo "Failed";
}
?>

