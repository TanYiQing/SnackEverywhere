<?php
include_once("dbconnect.php");
$email = $_POST['email'];

$sqlloadcard= "SELECT * FROM creditdebit_card WHERE email = '$email' ORDER BY card_id";
$result = $conn->query($sqlloadcard);

if ($result->num_rows > 0){
    $response["cards"] = array();
    while ($row = $result -> fetch_assoc()){
        $cardlist = array();
        $cardlist[email] = $row['email'];
        $cardlist[card_id] = $row['card_id'];
        $cardlist[card_number] = $row['card_number'];
        $cardlist[card_holder] = $row['card_holder'];
        $cardlist[cvv] = $row['cvv'];
        $cardlist[month] = $row['month'];
        $cardlist[year] = $row['year'];
        array_push($response["cards"],$cardlist);
    }
    echo json_encode($response);
}else{
    echo "nodata";
}
?>