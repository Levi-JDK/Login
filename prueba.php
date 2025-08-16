<?php
require 'conexion.php'; // Aquí está tu $conn
$db = new Database();
$pdo = $db->getPdo(); // <- Ahora sí tienes un PDO
$stmt = $pdo->prepare("SELECT mail_user FROM tab_users");
$stmt->execute();

while ($fila = $stmt->fetch(PDO::FETCH_ASSOC)) {
    echo $fila['mail_user'] . "\n";
}
?>