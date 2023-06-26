<?php 
	include 'database.php';

	$numControl = $_POST['numControl'];
	$idPersona = $_POST['idPersona'];
	$idGrupo = $_POST['idGrupo'];
	$semestre = $_POST['semestre'];
	$turno = $_POST['turno'];
	$especialidad = $_POST['especialidad'];

	$link->query("UPDATE alumno SET idPersona = '".$idPersona."',idGrupo = '".$idGrupo."',semestre = '".$semestre."',turno = '".$turno."',especialidad = '".$especialidad."' WHERE numControl = '".$numControl."'");


?>