<?php
	include 'database.php';
	
	
	$idGrupo = $_POST['idGrupo'];
	$idDoc = $_POST['idDoc'];


	$link->query("INSERT INTO grupodoc (idGrupo,idDoc)VALUES('".$idGrupo."','".$idDoc."')");

?>