
<?php 

	
$db = mysqli_connect('localhost','root','','justy');

	$query = $db->query("SELECT `justificacion`.*, `alumno`.*, `persona`.*
	FROM `justificacion` 
		LEFT JOIN `alumno` ON `justificacion`.`numControl` = `alumno`.`numControl` 
		LEFT JOIN `persona` ON `alumno`.`idPersona` = `persona`.`idPersona`;");
	$result = array();

	while ($rowData = $query->fetch_assoc()) {
		$result[] = $rowData;
	}


	echo json_encode($result);

