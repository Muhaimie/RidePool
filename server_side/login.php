<?php

    $Password = $_POST['Password'];
    $Email = $_POST['Email'];
    
    



    $user = "root";
    $pass = "";
    
    $conn = new mysqli("localhost",$user,$pass,"ridePool");
    
    if($conn->connect_error){
        die("Connection failed:" . $conn->connect_error);
    }
    
    $sql = "SELECT * FROM USER_DATA WHERE Email='".$Email."' AND Password='".$Password."'";
    
    $result = $conn->query($sql);
    
    if($result->num_rows > 0){
        while($row = $result->fetch_assoc()){
            echo $row["Name"];
            return;
        }
    }else{
        echo "no";
    }
    
    $conn->close();

?>
