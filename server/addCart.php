<?php
error_reporting(0);
include_once ("dbconnect.php");
$email = $_POST['email'];
$product_id = $_POST['product_id'];
$product_price=$_POST['product_price'];
$product_size=$_POST['product_size'];
$new_quantity = $_POST['quantity'];

$sqlcheck="SELECT * FROM product WHERE product_id='$product_id'";
$result1 = $conn->query($sqlcheck);
if($result1->num_rows>0){
    while($row = $result1 ->fetch_assoc()){
        if($product_size=="Small"){
            $instock_qty=$row["instock_qtysmall"];
        }else{
            $instock_qty=$row["instock_qtylarge"];
        }
        
        if($instock_qty<$new_quantity){
            echo "Failed";
        }else{
            $sqlsearch = "SELECT * FROM cart WHERE email = '$email' AND product_id= '$product_id' AND product_price='$product_price'";
            $result = $conn->query($sqlsearch);
            if ($result->num_rows > 0){
                while ($row = $result ->fetch_assoc()){
                    $c_quantity = $row["c_quantity"];   
                }
                $c_quantity = $c_quantity + $new_quantity;
                $sqlinsert = "UPDATE cart SET c_quantity = '$c_quantity' WHERE product_id = '$product_id' AND email = '$email' AND product_price='$product_price'";
            }else{
                $sqlinsert = "INSERT INTO cart(email,product_id,product_size,product_price,c_quantity) VALUES ('$email','$product_id','$product_size','$product_price','$new_quantity')";
            }
            if ($conn->query($sqlinsert) === true){
                $sqlinstock = "SELECT * FROM product WHERE product_id='$product_id'";
                $resulti=$conn->query($sqlinstock);
                if($resulti->num_rows>0){
                    while ($row = $resulti ->fetch_assoc()){
                        if($product_size=="Small"){
                            $lateststock=$row["instock_qtysmall"]-$new_quantity;
                            $sqlupdatepr="UPDATE product SET instock_qtysmall = '$lateststock' WHERE product_id='$product_id'";
                        }else{
                            $lateststock=$row["instock_qtylarge"]-$new_quantity;
                            $sqlupdatepr="UPDATE product SET instock_qtylarge = '$lateststock' WHERE product_id='$product_id'";
                        }
                        if($conn->query($sqlupdatepr)===TRUE){
                            echo "Success";
                        }else{
                            echo "Failed";
                        }
                    }
                }
                $sqlquantity = "SELECT * FROM cart WHERE email = '$email'";
                $resultq = $conn->query($sqlquantity);
                if ($resultq->num_rows > 0){
                    $quantity = 0;
                    while ($row = $resultq ->fetch_assoc()){
                        $quantity = $row["c_quantity"] + $quantity;
                    }
                }
                $quantity=$quantity;
                $sqlinsertqty="UPDATE cart SET t_quantity ='$quantity' WHERE email='$email'";
                if($conn->query($sqlinsertqty)===TRUE){
                    echo "Success";
                }else{
                    echo "Failed";
                }
                echo "Success,".$quantity;
            }else{
                echo "Failed";
            }
        }
    }
}else{
    echo "Failed";
}
    
?>