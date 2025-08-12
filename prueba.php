<?php
require 'conexion.php'; // Aquí está tu $conn

$sql = "SELECT id_user FROM tab_users";
$stmt = $conn->query($sql);

while ($fila = $stmt->fetch(PDO::FETCH_ASSOC)) {
    echo $fila['id_user'] . "\n";
}
?>