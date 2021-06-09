<?php
include_once("dbconnect.php");

$sqlloadissue= "SELECT * FROM reportIssue ORDER BY date_report DESC";
$result = $conn->query($sqlloadissue);

if ($result->num_rows > 0){
    $response["issues"] = array();
    while ($row = $result -> fetch_assoc()){
        $issuelist = array();
        $issuelist[report_id] = $row['report_id'];
        $issuelist[first_name] = $row['first_name'];
        $issuelist[last_name] = $row['last_name'];
        $issuelist[email] = $row['email'];
        $issuelist[issue] = $row['issue'];
        $issuelist[date_report] = $row['date_report'];
        array_push($response["issues"],$issuelist);
    }
    echo json_encode($response);
}else{
    echo "nodata";
}
?>