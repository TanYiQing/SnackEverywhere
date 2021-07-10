<?php
include_once("dbconnect.php");

$email=$_POST['email'];

if(isset($email)){
    $sqlloadproducts= "SELECT tbl_order.order_id,tbl_order.email,tbl_order.product_id,tbl_order.product_size,tbl_order.product_price,tbl_order.o_quantity,tbl_order.date_order,tbl_order.collect_option,tbl_order.collect_date,tbl_order.payment_option,tbl_order.status,tbl_order.receipt_id,product.product_name FROM tbl_order INNER JOIN product ON tbl_order.product_id=product.product_id WHERE email='$email' ORDER BY date_order DESC";
}else{
    $sqlloadproducts= "SELECT tbl_order.order_id,tbl_order.email,tbl_order.product_id,tbl_order.product_size,tbl_order.product_price,tbl_order.o_quantity,tbl_order.date_order,tbl_order.collect_option,tbl_order.collect_date,tbl_order.payment_option,tbl_order.status,tbl_order.receipt_id,product.product_name FROM tbl_order INNER JOIN product ON tbl_order.product_id=product.product_id ORDER BY date_order DESC";
}


$result = $conn->query($sqlloadproducts);
if ($result->num_rows > 0){
    $response["orders"] = array();
    while ($row = $result -> fetch_assoc()){
        $orderlist = array();
        $orderlist[order_id] = $row['order_id'];
        $orderlist[email] = $row['email'];
        $orderlist[product_id] = $row['product_id'];
        $orderlist[product_name] = $row['product_name'];
        $orderlist[product_size] = $row['product_size'];
        $orderlist[product_price] = $row['product_price'];
        $orderlist[o_quantity] = $row['o_quantity'];
        $orderlist[date_order] = $row['date_order'];
        $orderlist[collect_option] = $row['collect_option'];
        $orderlist[collect_date] = $row['collect_date'];
        $orderlist[payment_option] = $row['payment_option'];
        $orderlist[status] = $row['status'];
        $orderlist[receipt_id] = $row['receipt_id'];
        array_push($response["orders"],$orderlist);
    }
    echo json_encode($response);
  
}else{
    echo "nodata";
}
?>