<?php include 'database.php';

	$numControl = $_POST['numControl'];

	$link->query("DELETE FROM alumno WHERE numControl = '".$numControl."'");