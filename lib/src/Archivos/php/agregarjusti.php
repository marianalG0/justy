<?php
	include 'database.php';

	$idJusty = $_POST['idJusty'];
	$numControl = $_POST['numControl'];
	$idGrupoDoc = $_POST['idGrupoDoc'];
	$fechaInicio = $_POST['fechaInicio'];
	$fechaFinal = $_POST['fechaFinal'];
	$horaInicio = $_POST['horaInicio'];
    $horaFinal = $_POST['horaFinal'];
	$motivo = $_POST['motivo'];

	$link->query("INSERT INTO justificacion (numControl,idGrupoDoc,fechaInicio,fechaFinal,horaInicio,horaFinal,motivo)VALUES('".$numControl."','".$idGrupoDoc."','".$fechaInicio."','".$fechaFinal."','".$horaInicio."','".$horaFinal."','".$motivo."')");

?>