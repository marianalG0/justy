<?php 

include 'database.php';

$materia = $_POST['materia'];
$per = $_POST['per'];

$link->query("UPDATE docente SET materia = '".$materia."',per = '".$per."' WHERE idDoc = '".$idDoc."'");