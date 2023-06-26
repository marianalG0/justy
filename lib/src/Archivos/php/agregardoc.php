<?php
	include 'database.php';
	
	$materia = $_POST['materia'];
	$idPersona = $_POST['idPersona'];


	$link->query("INSERT INTO docentes (materia,idPersona)VALUES('".$materia."','".$idPersona."')");

?>