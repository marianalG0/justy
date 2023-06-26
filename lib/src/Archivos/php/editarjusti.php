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


	$link->query("UPDATE justificacion SET numControl = '".$numControl."',idGrupoDoc = '".$idGrupoDoc."',fechaInicio = '".$fechaInicio."',fechaFinal = '".$fechaFinal."',horaInicio = '".$horaInicio."',horaFinal = '".$horaFinal."',motivo = '".$motivo."' WHERE idJusty = '".$idJusty."'");


?>