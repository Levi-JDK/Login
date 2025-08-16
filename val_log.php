<?php
require_once('conexion.php');
$db = new Database();
$pdo = $db->getPdo();

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $email      = $_POST['email'] ?? '';
    $contrasena = $_POST['contrasena'] ?? '';


    if (empty($email) || empty($contrasena)) {
        echo json_encode([
            "mensaje" => "Todos los campos son obligatorios.",
            "clase"   => "mensaje-error"
        ]);
        exit;
    }

    if (preg_match('/["\']/', $email)) {
        die("Email inválido: no se permiten comillas");
    }

    try {
        
        $sqlpass = "SELECT fun_val_log(:email)";
        $stmt    = $pdo->prepare($sqlpass);
        $stmt->bindParam(':email', $email, PDO::PARAM_STR);
        $stmt->execute();

        $hash = $stmt->fetchColumn(); 
        if ($hash && password_verify($contrasena, $hash)) {
            echo json_encode([
                "mensaje" => "✅ Contraseña válida",
                "clase"   => "mensaje-exito"
            ]);
        } else {
            echo json_encode([
                "mensaje" => "❌ Contraseña incorrecta",
                "clase"   => "mensaje-error"
            ]);
        }

    } catch (PDOException $e) {
        echo json_encode([
            "mensaje" => "Error en la base de datos: " . $e->getMessage(),
            "clase"   => "mensaje-error"
        ]);
    }
}

