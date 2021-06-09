<?php
include_once("dbconnect.php");
$email = $_POST['email'];

$sqlloadbillingaddress= "SELECT * FROM billing_address WHERE email = '$email' ORDER BY billing_id";
$result = $conn->query($sqlloadbillingaddress);

if ($result->num_rows > 0){
    $response["billingaddresses"] = array();
    while ($row = $result -> fetch_assoc()){
        $billingaddresslist = array();
        $billingaddresslist[email] = $row['email'];
        $billingaddresslist[billing_id] = $row['billing_id'];
        $billingaddresslist[b_name] = $row['b_name'];
        $billingaddresslist[b_phone] = $row['b_phone'];
        $billingaddresslist[b_address1] = $row['b_address1'];
        $billingaddresslist[b_address2] = $row['b_address2'];
        $billingaddresslist[b_address3] = $row['b_address3'];
        $billingaddresslist[b_zip] = $row['b_zip'];
        $billingaddresslist[b_city] = $row['b_city'];
        $billingaddresslist[b_state] = $row['b_state'];
        array_push($response["billingaddresses"],$billingaddresslist);
    }
    echo json_encode($response);
}else{
    echo "nodata";
}
?>