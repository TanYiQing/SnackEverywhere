<?php
error_reporting(0);
include_once("dbconnect.php");
$email=$_GET['email'];
$name=$_GET['name'];
$subtotal=$_GET['subtotal'];
$deliverycharge=$_GET['deliverycharge'];
$discount=$_GET['discount'];
$orderamount=$_GET['orderamount'];
$paymentoption=$_GET['paymentoption'];
$collectoption=$_GET['collectoption'];
$collectdate=$_GET['collectdate'];
$status="Order Received";
$address=$_GET['address'];


$data = array(
    'id' =>  $_GET['billplz']['id'],
    'paid_at' => $_GET['billplz']['paid_at'] ,
    'paid' => $_GET['billplz']['paid'],
    'x_signature' => $_GET['billplz']['x_signature']
);

$paidstatus = $_GET['billplz']['paid'];

if ($paidstatus=="true"){
  $receiptid = $_GET['billplz']['id'];
  $signing = '';
    foreach ($data as $key => $value) {
        $signing.= 'billplz'.$key . $value;
        if ($key === 'paid') {
            break;
        } else {
            $signing .= '|';
        }
    }
    $sqltransfer="INSERT INTO tbl_order(email,product_id,product_size,product_price,o_quantity) SELECT email,product_id,product_size,product_price,c_quantity FROM cart WHERE email='$email'";
if($conn->query($sqltransfer)===true){
    $sqlpublish="UPDATE tbl_order SET collect_option='$collectoption', collect_date='$collectdate', payment_option='$paymentoption', status='$status', address='$address',receipt_id='$receiptid' WHERE date_order=(SELECT MAX(date_order) FROM tbl_order) AND email='$email'";
    if($conn->query($sqlpublish)===true){
        $sqlclearcart="DELETE FROM cart WHERE email='$email'";
        if($conn->query($sqlclearcart)===true){
             
        }
    }else{
        echo "Failed";
    }
    
}else{
    echo "Failed";
}

date_default_timezone_set("Asia/Kuala_Lumpur");
    echo '
    <br>
    <br>
    <body>
    <div>
    <h2>
    <br>
    <br>
    <center><div style="background-color:orange">Order Receipt<img src="../images/bill/paid_96px.png" style="height:35px;width:35px"></center>
    </h2>
    </div>
    <div style="background-color:OldLace; padding:20px 20px 20px 20px">
        <table border=0 width=90% align=center>
        <tr><td>Receipt ID</td><td>'.$receiptid.'</td></tr>
        <tr><td>Email to </td><td>'.$email. ' </td></tr>
        <td>Amount </td><td>RM '.$orderamount.'</td></tr>
        <tr><td>Payment Status </td><td style="color:green">Paid Successful</td></tr>
        <tr><td>Date </td><td>'.date("d/m/Y").'</td></tr>
        <tr><td>Time </td><td>'.date("h:i a").'</td></tr>
        </table>
    </div>
   
    <br>
    <p><center>Press back button to return to SnackEverywhere</center></p>
    </div>
    </body>';
    
}
else{
     echo 'Payment Failed!';
}
?>