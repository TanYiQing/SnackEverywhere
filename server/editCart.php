<?php
include_once("dbconnect.php");
$email=$_POST['email'];
$product_id=$_POST['product_id'];
$product_price=$_POST['product_price'];
$product_size=$_POST['product_size'];   
$quantity=$_POST['quantity'];

$sqleditcart="UPDATE cart SET c_quantity='$quantity' WHERE email='$email' AND product_id='$product_id' AND product_price='$product_price'";
if($conn->query($sqleditcart)===TRUE){
    // echo "Success";
    $sqlquantity = "SELECT * FROM cart WHERE email = '$email'";
    $resultq = $conn->query($sqlquantity);
    if ($resultq->num_rows > 0){
        $quantity = 0;
        while ($row = $resultq ->fetch_assoc()){
            $quantity = $row["c_quantity"] + $quantity;
        }
        $quantity=$quantity;
        $sqlinsertqty="UPDATE cart SET t_quantity ='$quantity' WHERE email='$email'";
        if($conn->query($sqlinsertqty)===TRUE){
            echo "Success";
        }else{
            echo "Failed";
        }
    }
}else{
echo "Failed";
}
?>