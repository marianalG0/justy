<?php 

include 'database.php';

$materia = $_POST['materia'];
$per = $_POST['per'];

$link->query("INSERT INTO docente(materia,per)VALUES('".$materia."','".$per."')");