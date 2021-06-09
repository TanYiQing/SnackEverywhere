<?php
include_once("dbconnect.php");
$product_id=$_POST['product_id'];
$product_name=$_POST['product_name'];
$product_desc=$_POST['product_desc'];
$product_small_price=$_POST['product_small_price'];
$product_small_qty=$_POST['product_small_qty'];
$product_large_price=$_POST['product_large_price'];
$product_large_qty=$_POST['product_large_qty'];
$product_cat=$_POST['product_cat'];
$instock_qtysmall=$_POST['instock_qtysmall'];
$instock_qtylarge=$_POST['instock_qtylarge'];
//$encoded_string=$_POST['encoded_string'];

$sqleditproduct="UPDATE product SET product_name='$product_name',product_desc='$product_desc',product_small_price='$product_small_price',product_small_qty='$product_small_qty',product_large_price='$product_large_price',product_large_qty='$product_large_qty',product_cat='$product_cat', instock_qtysmall='$instock_qtysmall',instock_qtylarge='$instock_qtylarge' WHERE product_id='$product_id'";
if($conn->query($sqleditproduct)===TRUE){
   /* $decoded_string=base64_decode($encoded_string);
    $path='../images/product/'.$product_id.'.png';
    $is_written=file_put_contents($path,$decoded_string);*/
    echo "Success";
}else{
echo "Failed";
}
?>