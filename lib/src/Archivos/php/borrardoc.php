<?php include 'database.php';

	$idDoc = $_POST['idDoc'];

	$link->query("DELETE FROM docentes WHERE idDoc = '".$idDoc."'");