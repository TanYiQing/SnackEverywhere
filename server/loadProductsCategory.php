<?php
include_once("dbconnect.php");

$product_cat=$_POST['product_cat'];
$product_name=$_POST['product_name'];

if (isset($product_cat)){
    if($product_cat=="All"){
        $sqlloadproducts= "SELECT * FROM product ORDER BY datePublished DESC";     
    }else{
        $sqlloadproducts= "SELECT * FROM product WHERE product_cat='$product_cat' ORDER BY datePublished DESC";     
    }
   
}

if (isset($product_name)){
   $sqlloadproducts= "SELECT * FROM product WHERE product_name LIKE  '%$product_name%'";
}


$result = $conn->query($sqlloadproducts);

if ($result->num_rows > 0){
    $response["products"] = array();
    while ($row = $result -> fetch_assoc()){
        $productlist = array();
        $productlist[product_id] = $row['product_id'];
        $productlist[product_name] = $row['product_name'];
        $productlist[product_desc] = $row['product_desc'];
        $productlist[product_small_price] = $row['product_small_price'];
        $productlist[product_small_qty] = $row['product_small_qty'];
        $productlist[product_large_price] = $row['product_large_price'];
        $productlist[product_large_qty] = $row['product_large_qty'];
        $productlist[product_cat] = $row['product_cat'];
        $productlist[instock_qtysmall] = $row['instock_qtysmall'];
        $productlist[instock_qtylarge] = $row['instock_qtylarge'];
        $productlist[datePublished] = $row['datePublished'];
        array_push($response["products"],$productlist);
    }
    echo json_encode($response);
}else{
    echo "nodata";
}
?>