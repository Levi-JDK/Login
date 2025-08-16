<?php
require_once('conexion.php');
$db = new Database();
$pdo = $db->getPdo();
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $email = $_POST['email'] ?? '';
    $contrasena = $_POST['contrasena'] ?? '';

    if (empty($email) || empty($contrasena)) {
        echo "{
            \"mensaje\": \"Todos los campos son obligatorios.\",
            \"clase\": \"mensaje-error\"
        }";;
        exit;
    }
?>