<?php
error_reporting(0);

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

$api_key='08bfa8ac-b29e-45c2-aa30-539da041c4f2';
$collection_id='kdszx4tx';
$host='https://billplz-staging.herokuapp.com/api/v3/bills';

$data = array(
    'collection_id' => $collection_id,
    'email' => $email,
    'name'=> $name,
    'subtotal' => $subtotal,
    'deliverycharge' => $deliverycharge,
    'discount' => $discount,
    'amount' => $orderamount*100,
    'paymentoption' => $paymentoption,
    'description' => 'Payment for order',
    'callback_url'=>"https://hubbuddies.com/270607/snackeverywhere/php/return_url",
    'redirect_url'=>"https://hubbuddies.com/270607/snackeverywhere/php/payment_update.php?email=$email&subtotal=$subtotal&deliverycharge=$deliverycharge&discount=$discount&orderamount=$orderamount&paymentoption=$paymentoption&collectoption=$collectoption&collectdate=$collectdate&status=$status&address=$address"
    );
    
$process = curl_init($host);
curl_setopt($process, CURLOPT_HEADER, 0);
curl_setopt($process, CURLOPT_USERPWD, $api_key . ":");
curl_setopt($process, CURLOPT_TIMEOUT, 30);
curl_setopt($process, CURLOPT_RETURNTRANSFER, 1);
curl_setopt($process, CURLOPT_SSL_VERIFYHOST, 0);
curl_setopt($process, CURLOPT_SSL_VERIFYPEER, 0);
curl_setopt($process, CURLOPT_POSTFIELDS, http_build_query($data) );

$return = curl_exec($process);
curl_close($process);

$bill = json_decode($return, true);

echo "<pre>".print_r($bill,true)."</pre>";
header("Location:{$bill['url']}");

?>