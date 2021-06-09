<?php
$servername = "localhost";
$username   = "hubbuddi_snackeverywhereadmin";
$password   = "bu@uje,zI50(";
$dbname     = "hubbuddi_snackeverywheredb";

$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

?>