<?php
require_once('conexion.php');
$db = new Database();
$pdo = $db->getPdo(); // <- Ahora sí tienes un PDO

if (isset($_POST['email'], $_POST['contrasena'], $_POST['nombre'], $_POST['apellido'])) {
    // Recogemos los datos del formulario
    $nombre = $_POST['nombre'];
    $email = $_POST['email'];
    $contrasena = password_hash($_POST['contrasena'], PASSWORD_ARGON2ID); // Hash de la contraseña
    $apellido = $_POST['apellido'];
    $sqlcheck = "SELECT fun_val_mail(:email)";
    $stmtcheck = $pdo->prepare($sqlcheck);
    $stmtcheck->bindParam(':email', $email, PDO::PARAM_STR);
    $stmtcheck->execute();
    $result = $stmtcheck->fetchColumn();
    if ($result == false) {
        $error = "El correo ya está registrado.";
    } else {
        $sql = "SELECT fun_reg_user(:email, :contrasena, :nombre, :apellido)";
        $stmt = $pdo->prepare($sql);
        // Vincular parámetros
        $stmt->bindParam(':nombre', $nombre, PDO::PARAM_STR);
        $stmt->bindParam(':email', $email, PDO::PARAM_STR);
        $stmt->bindParam(':contrasena', $contrasena, PDO::PARAM_STR);
        $stmt->bindParam(':apellido', $apellido, PDO::PARAM_STR);

        // Ejecutar la consulta
        $stmt->execute();
    }
}
?>
