<?php include 'database.php';

	$idJusty = $_POST['idJusty'];

	$link->query("DELETE FROM justificacion WHERE idJusty = '".$idJusty."'");