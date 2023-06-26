<?php 
	include 'database.php';

	$idDoc = $_POST['idDoc'];
	$materia = $_POST['materia'];
	$idPersona = $_POST['idPersona'];


	$link->query("UPDATE docentes SET materia = '".$materia."',idPersona = '".$idPersona."' WHERE idDoc = '".$idDoc."'");


?>