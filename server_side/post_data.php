<?
	
$Name = $_POST['Name'];
$Password = $_POST['Password'];
$Email = $_POST['Email'];



$dsn = "mysql:host=localhost;dbname=ridePool";
$user = "root";
$pass = "";

$pdo = new PDO($dsn,$user,$pass);


try{
    $pdo->beginTransaction();
    $stm= $pdo->exec("INSERT INTO USER_DATA(Name, Password, Email) VALUES('".$Name."','".$Password."','".$Email."')");
    $pdo->commit();
    echo 1;
}catch(Exception $e){
    $pdo->rollback();
    echo $e;
}





?>
