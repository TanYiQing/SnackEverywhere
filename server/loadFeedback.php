<?php
include_once("dbconnect.php");

$sqlloadfeedback= "SELECT * FROM feedback ORDER BY date_feedback DESC";
$result = $conn->query($sqlloadfeedback);

if ($result->num_rows > 0){
    $response["feedbacks"] = array();
    while ($row = $result -> fetch_assoc()){
        $feedbacklist = array();
        $feedbacklist[feedback_id] = $row['feedback_id'];
        $feedbacklist[first_name] = $row['first_name'];
        $feedbacklist[last_name] = $row['last_name'];
        $feedbacklist[email] = $row['email'];
        $feedbacklist[feedback] = $row['feedback'];
        $feedbacklist[date_feedback] = $row['date_feedback'];
        array_push($response["feedbacks"],$feedbacklist);
    }
    echo json_encode($response);
}else{
    echo "nodata";
}
?>