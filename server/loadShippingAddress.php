<?php
include_once("dbconnect.php");
$email = $_POST['email'];

$sqlloadshippingaddress= "SELECT * FROM shipping_address WHERE email = '$email' ORDER BY shipping_id";
$result = $conn->query($sqlloadshippingaddress);

if ($result->num_rows > 0){
    $response["shippingaddresses"] = array();
    while ($row = $result -> fetch_assoc()){
        $shippingaddresslist = array();
        $shippingaddresslist[email] = $row['email'];
        $shippingaddresslist[shipping_id] = $row['shipping_id'];
        $shippingaddresslist[s_name] = $row['s_name'];
        $shippingaddresslist[s_phone] = $row['s_phone'];
        $shippingaddresslist[s_address1	] = $row['s_address1'];
        $shippingaddresslist[s_address2] = $row['s_address2'];
        $shippingaddresslist[s_address3] = $row['s_address3'];
        $shippingaddresslist[s_zip] = $row['s_zip'];
        $shippingaddresslist[s_city] = $row['s_city'];
        $shippingaddresslist[s_state] = $row['s_state'];
        array_push($response["shippingaddresses"],$shippingaddresslist);
    }
    echo json_encode($response);
}else{
    echo "nodata";
}
?>