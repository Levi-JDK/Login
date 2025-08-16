<?php
require_once('conexion.php');
header('Content-Type: application/json');

$db = new Database();
$pdo = $db->getPdo();

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $nombre = $_POST['nombre'] ?? '';
    $apellido = $_POST['apellido'] ?? '';
    $email = $_POST['email'] ?? '';
    $contrasena = $_POST['contrasena'] ?? '';

    if (empty($nombre) || empty($apellido) || empty($email) || empty($contrasena)) {
        echo json_encode([
            "mensaje" => "Todos los campos son obligatorios.",
            "clase" => "mensaje-error"
        ]);
        exit;
    }

    $hash = password_hash($contrasena, PASSWORD_ARGON2ID);

    try {
        $sqlcheck = "SELECT fun_val_mail(:email)";
        $stmtcheck = $pdo->prepare($sqlcheck);
        $stmtcheck->bindParam(':email', $email, PDO::PARAM_STR);
        $stmtcheck->execute();
        $result = $stmtcheck->fetchColumn();

        if (!$result) {
            echo json_encode([
                "mensaje" => "El correo ya está registrado.",
                "clase" => "mensaje-error"
            ]);
            exit;
        }

        $sql = "SELECT fun_reg_user(:email, :contrasena, :nombre, :apellido)";
        $stmt = $pdo->prepare($sql);
        $stmt->bindParam(':nombre', $nombre, PDO::PARAM_STR);
        $stmt->bindParam(':email', $email, PDO::PARAM_STR);
        $stmt->bindParam(':contrasena', $hash, PDO::PARAM_STR);
        $stmt->bindParam(':apellido', $apellido, PDO::PARAM_STR);
        $stmt->execute();

        echo json_encode([
            "mensaje" => "Usuario registrado correctamente.",
            "clase" => "mensaje-exito"
        ]);
    } catch (PDOException $e) {
        echo json_encode([
            "mensaje" => "Error en el registro.",
            "clase" => "mensaje-error"
        ]);
    }
}