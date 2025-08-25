<?php
require_once('conexion.php');
header('Content-Type: application/json');

$db = new Database();
$pdo = $db->getPdo();

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $accion = $_POST['accion'] ?? '';

    if ($accion === 'registro') {
        // Registro
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

        // Validar formato de email
        if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
            echo json_encode([
                "mensaje" => "El correo electrónico no es válido.",
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
            $stmt->bindParam(':email', $email, PDO::PARAM_STR);
            $stmt->bindParam(':contrasena', $hash, PDO::PARAM_STR);
            $stmt->bindParam(':nombre', $nombre, PDO::PARAM_STR);
            $stmt->bindParam(':apellido', $apellido, PDO::PARAM_STR);
            $stmt->execute();

            echo json_encode([
                "mensaje" => "Usuario registrado correctamente.",
                "clase" => "mensaje-exito"
            ]);
        } catch (PDOException $e) {
            echo json_encode([
                "mensaje" => "Error en el registro: " . $e->getMessage(),
                "clase" => "mensaje-error"
            ]);
        }
    } elseif ($accion === 'login') {
        // Login
        $email = $_POST['email'] ?? '';
        $contrasena = $_POST['contrasena'] ?? '';

        if (empty($email) || empty($contrasena)) {
            echo json_encode([
                "mensaje" => "Todos los campos son obligatorios.",
                "clase" => "mensaje-error"
            ]);
            exit;
        }

        if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
            echo json_encode([
                "mensaje" => "El correo electrónico no es válido.",
                "clase" => "mensaje-error"
            ]);
            exit;
        }

        try {
            // Usar fun_val_log para obtener el hash
            $sqlpass = "SELECT fun_val_log(:email)";
            $stmt = $pdo->prepare($sqlpass);
            $stmt->bindParam(':email', $email, PDO::PARAM_STR);
            $stmt->execute();
            $hash = $stmt->fetchColumn();

            if ($hash && password_verify($contrasena, $hash)) {
                // Iniciar sesión
                session_start();
                $_SESSION['email'] = $email;

                // Consulta adicional para obtener el nombre
                $sqlNombre = "SELECT nom_user FROM tab_users WHERE mail_user = :email";
                $stmtNombre = $pdo->prepare($sqlNombre);
                $stmtNombre->bindParam(':email', $email, PDO::PARAM_STR);
                $stmtNombre->execute();
                $nombre = $stmtNombre->fetchColumn();

                if ($nombre) {
                    $_SESSION['nombre'] = $nombre;
                } else {
                    $_SESSION['nombre'] = $email;
                }

                echo json_encode([
                    "mensaje" => "✅ Inicio de sesión exitoso",
                    "clase" => "mensaje-exito"
                ]);
            } else {
                echo json_encode([
                    "mensaje" => "❌ Correo o contraseña incorrectos",
                    "clase" => "mensaje-error"
                ]);
            }
        } catch (PDOException $e) {
            echo json_encode([
                "mensaje" => "Error en la base de datos: " . $e->getMessage(),
                "clase" => "mensaje-error"
            ]);
        }
    } else {
        echo json_encode([
            "mensaje" => "Acción no válida.",
            "clase" => "mensaje-error"
        ]);
    }
}
?>