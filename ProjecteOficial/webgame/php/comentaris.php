<?php
	//Servidor, usuari, contrasenya, basededades.
	$connexio = new mysqli('localhost', 'root', '', 'jocsmbf');	
	
	if ($_SERVER["REQUEST_METHOD"] == "POST") {
		if (empty($_POST["name"])) {
			//El nom es opcional, no hi ha problema al no rebre'l.
			//echo $nameErr = "El Nom està buit.";
			$name = "";
		} else {
			$name = $_POST["name"];
		}
		
		if (empty($_POST["email"])) {
			$emailErr = "L'Email està buit.";
		} else {
			$email = $_POST["email"];
		}
		
		if (empty($_POST["message"])) {
			$msgErr = "El missatge està buit.";
		} else {
			$msg = $_POST["message"];
		}
	
		$query = "insert into comentaris(nom,email,missatge) values ('$name','$email','$msg')";
			
		$result = mysqli_query($connexio,$query);
		
		header("Location: ../5-contact.html");
	}
?>