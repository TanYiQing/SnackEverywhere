<?php

use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;

require '/home8/hubbuddi/public_html/270607/snackeverywhere/php/PHPMailer/Exception.php';
require '/home8/hubbuddi/public_html/270607/snackeverywhere/php/PHPMailer/PHPMailer.php';
require '/home8/hubbuddi/public_html/270607/snackeverywhere/php/PHPMailer/SMTP.php';

include_once("dbconnect.php");

$email=$_POST['email'];
$otp=rand(100000,999999);

$sqlforget = "SELECT * FROM tbl_user WHERE email= '$email'";
$result = $conn-> query ($sqlforget);
if($result ->num_rows>0){
    $sqlupdate= "UPDATE tbl_user SET resetotp='$otp' WHERE email='$email' AND otp='0'";
    if($conn->query($sqlupdate)===TRUE){
        echo 'Success';
        sendEmail($email,$otp);
        
    }else{
        echo 'Failed';
    }
}else{
    echo 'Failed';
}

function sendEmail($email,$otp){
    $mail = new PHPMailer(true);
    $mail->SMTPDebug = 0; //Disable verbose debug output
    $mail->isSMTP(); //Send using SMTP
    $mail->Host= 'mail.hubbuddies.com'; //Set the SMTP server to send through
    $mail->SMTPAuth= true; //Enable SMTP authentication
    $mail->Username= 'snackeverywhere@hubbuddies.com'; //SMTP username
    $mail->Password= 'snackeverywhere'; //SMTP password
    $mail->SMTPSecure= 'tls';         
    $mail->Port= 587;
    
    $from = "snackeverywhere@hubbuddies.com";
    $to = $email;
    $subject = "Reset Password";
    $message = "Hi,<br><br>
    
	            Your username with $email have been requested to reset password.<br><br>
	            
                The OTP is <u>$otp</u>.<br>
                Please enter this OTP in SnackEveryWhere Application to reset password.
                <br><br><br><br><br><br><br><br><br><br><br><br>
                
                
                
                
                
                You have been sent this email because an action of reset password was requested on SnackEverywhere with the email address <u>$email</u><br>
                If you have received it in error, please validate your account security";
    
    $mail->setFrom($from,"SnackEverywhere");
    $mail->addAddress($to);//Add a recipient
    
    //Content
    $mail->isHTML(true);//Set email format to HTML
    $mail->Subject = $subject;
    $mail->Body    = $message;
    $mail->send();
}

?>