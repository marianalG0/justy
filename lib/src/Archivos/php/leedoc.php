
<?php 

	
$db = mysqli_connect('localhost','root','','justy');

$query = $db->query("SELECT docentes.*, persona.*
FROM docentes
JOIN persona ON docentes.per_id = persona.idPersona");
$result = array();

	while ($rowData = $query->fetch_assoc()) {
		$result[] = $rowData;
	}


	echo json_encode($result);










































// include 'database.php';

// 	$query = $link->query('SELECT * FROM person');
// 	$result = array();

// 	while ($rowdata = $query->fetch_assoc()) {
// 		$result[] = $rowdata;
// 	}
// 	echo json_encode($result);