<?php
include_once("dbconnect.php");
$product_name=$_POST['product_name'];
$product_desc=$_POST['product_desc'];
$product_small_price=$_POST['product_small_price'];
$product_small_qty=$_POST['product_small_qty'];
$product_large_price=$_POST['product_large_price'];
$product_large_qty=$_POST['product_large_qty'];
$product_cat=$_POST['product_cat'];
$instock_qtysmall=$_POST['instock_qtysmall'];
$instock_qtylarge=$_POST['instock_qtylarge'];
$encoded_string=$_POST['encoded_string'];

$sqlpublish="INSERT INTO product(product_name,product_desc,product_small_price,product_small_qty,product_large_price,product_large_qty,product_cat,instock_qtysmall,instock_qtylarge) VALUES('$product_name','$product_desc','$product_small_price','$product_small_qty','$product_large_price','$product_large_qty','$product_cat','$instock_qtysmall','$instock_qtylarge')";
if($conn->query($sqlpublish)===true){
    $decoded_string=base64_decode($encoded_string);
    $filename=mysqli_insert_id($conn);
    $path= '../images/product/'.$filename.'.png';
    $is_written=file_put_contents($path,$decoded_string);
    echo "Success";
}else{
    echo "Failed";
}
?>