<?php
error_reporting(0);
include_once ("dbconnect.php");
$email = $_POST['email'];

if (isset($email)){
   $sqlcart = "SELECT product.product_id, product.product_name, product.product_cat, cart.product_size, cart.product_price, cart.c_quantity, cart.t_quantity FROM product INNER JOIN cart ON cart.product_id = product.product_id WHERE cart.email = '$email'";
}

$result = $conn->query($sqlcart);

if ($result->num_rows > 0)
{
    $response["cart"] = array();
    while ($row = $result->fetch_assoc())
    {
        $cartlist = array();
        $cartlist["product_id"] = $row["product_id"];
        $cartlist["product_name"] = $row["product_name"];
        $cartlist["product_size"] = $row["product_size"];
        $cartlist["product_price"] = $row["product_price"];
        $cartlist["c_quantity"] = $row["c_quantity"];
        $cartlist["totalprice"] = number_format((float)round(doubleval($row["product_price"])*(doubleval($row["c_quantity"])),2)."",2,".",'');
        $grandtotal=$grandtotal+$cartlist["totalprice"];
        $cartlist["grandtotal"] =number_format((float)round(doubleval($grandtotal),2)."",2,".",'');
        $cartlist["t_quantity"] = $row["t_quantity"];
        array_push($response["cart"], $cartlist);
    }
    echo json_encode($response);
}
else
{
    echo "Cart Empty";
}
?>