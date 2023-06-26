<?php
$servername = "localhost"; // Cambia esto si el servidor de la base de datos no está en localhost
$username = "root";
$password = "";
$dbname = "justy";

$numControl = $_POST['numControl'];
// Crea una conexión a la base de datos
$conn = new mysqli($servername, $username, $password, $dbname);

// Verifica la conexión
if ($conn->connect_error) {
    die("Error en la conexión a la base de datos: " . $conn->connect_error);
}

// Realizar la consulta en la base de datos
$query = "SELECT * FROM alumno WHERE numControl LIKE '%$numControl%'";
$result = mysqli_query($conn, $query);

// Verificar si se encontraron resultados
if (mysqli_num_rows($result) > 0) {
    $response = array();
    while ($row = mysqli_fetch_assoc($result)) {
        $response[] = $row;
    }
    echo json_encode($response);
} else {
    echo json_encode([]); // Devolver un array vacío si no se encontraron resultados
}

// Cerrar la conexión a la base de datos
mysqli_close($conn);
?>