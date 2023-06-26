<?php
	include 'database.php';
	
	$numControl = $_POST['numControl'];
	$idPersona = $_POST['idPersona'];
	$idGrupo = $_POST['idGrupo'];
	$semestre = $_POST['semestre'];
	$turno = $_POST['turno'];
	$especialidad = $_POST['especialidad'];

	$link->query("INSERT INTO alumno (numControl,idPersona,idGrupo,semestre,turno,especialidad)VALUES('".$numControl."','".$idPersona."','".$idGrupo."','".$semestre."','".$turno."','".$especialidad."')");

?>