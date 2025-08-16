<?php
require_once('conexion.php');
$db = new Database();
$pdo = $db->getPdo();
$error = "";
$registro_exitoso = false;

if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['email'], $_POST['contrasena'], $_POST['nombre'], $_POST['apellido'])) {
    $nombre = $_POST['nombre'];
    $apellido = $_POST['apellido'];
    $email = $_POST['email'];
    $contrasena = password_hash($_POST['contrasena'], PASSWORD_ARGON2ID);

    try {
        $sqlcheck = "SELECT fun_val_mail(:email)";
        $stmtcheck = $pdo->prepare($sqlcheck);
        $stmtcheck->bindParam(':email', $email, PDO::PARAM_STR);
        $stmtcheck->execute();
        $result = $stmtcheck->fetchColumn();

        if (!$result) {
            $error = "El correo ya está registrado.";
        } else {
            $sql = "SELECT fun_reg_user(:email, :contrasena, :nombre, :apellido)";
            $stmt = $pdo->prepare($sql);
            $stmt->bindParam(':nombre', $nombre, PDO::PARAM_STR);
            $stmt->bindParam(':email', $email, PDO::PARAM_STR);
            $stmt->bindParam(':contrasena', $contrasena, PDO::PARAM_STR);
            $stmt->bindParam(':apellido', $apellido, PDO::PARAM_STR);
            $stmt->execute();

            $registro_exitoso = true;
        }
    } catch (PDOException $e) {
        $error = "Correo en uso";
    }
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Quattrocento:wght@400;700&family=Lato:wght@400;700&display=swap" rel="stylesheet">
	<link rel="stylesheet" type="text/css" href="styles.css">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
	<title>Login Viva</title>
</head>
<body>
	<header class="header">
		<div class="header-content">
			<div class="logo-container">
				<h1>VIVA</h1>
			</div>
			<nav class="nav-principal">
				<ul>
					<li><a href="#inicio">Inicio</a></li>
					<li><a href="#productos">Productos</a></li>
					<li><a href="#historia">Nuestra Historia</a></li>
					<li><a href="#contacto">Contacto</a></li>
				</ul>
			</nav>
		</div>
	</header>

	<div class="center">
		<div class="container" id="container">
			<div class="form-container sign-up-container">
				<form action="login.php" method="POST">
					<h1>Crear Cuenta</h1>
					<div class="social-container">
						<a href="#" class="social"><i class="fab fa-facebook-f"></i></a>
						<a href="#" class="social"><i class="fab fa-google-plus-g"></i></a>
					</div>
					<span>o usa tu correo para registrarte</span>
					<input type="text" name="nombre" placeholder="Nombre" required />
					<input type="text" name="apellido" placeholder="Apellido" required />
					<input type="email" name="email" placeholder="Email" required />
					<input type="password" name="contrasena" placeholder="Contraseña" required />
					<?php if ($error): ?>
						<p id="p_error" class="mensaje-error">Correo electrónico en uso.</p>
					<?php elseif ($registro_exitoso): ?>
						<p id="p_exito" class="mensaje-exito">¡Registro exitoso! Ahora puedes iniciar sesión.</p>
					<?php endif; ?>
					<button type="submit">Registrarse</button>
				</form>
			</div>
			<div class="form-container sign-in-container">
				<form action="#">
					<h1>Iniciar Sesión</h1>
					<div class="social-container">
						<a href="#" class="social"><i class="fab fa-facebook-f"></i></a>
						<a href="#" class="social"><i class="fab fa-google-plus-g"></i></a>
					</div>
					<span>o usa tu cuenta</span>
					<input type="email" placeholder="Email" />
					<input type="password" placeholder="Contraseña" />
					<a href="#">¿Olvidaste tu contraseña?</a>
					<button>Iniciar Sesión</button>
				</form>
			</div>
			<div class="overlay-container">
				<div class="overlay">
					<div class="overlay-panel overlay-left">
						<h1>¡Bienvenido de nuevo!</h1>
						<p>Para mantenerte conectado con nosotros, por favor inicia sesión con tu información personal</p>
						<button class="ghost" id="signIn">Iniciar Sesión</button>
					</div>
					<div class="overlay-panel overlay-right">
						<h1>¡Hola, Amigo!</h1>
						<p>Descubre una artesanía que cuente nuestra historia.</p>
						<button class="ghost" id="signUp">Registrarse</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<footer>
		<p>©2025 VIVA. Todos los derechos reservados.</p>
		<a href="politica.html">Política de privacidad</a> |
		<a href="terminos.html">Términos y condiciones</a>
	</footer>
	<script src="script.js"></script>
</body>
</html>