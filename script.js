const signUpButton = document.getElementById('signUp');
const signInButton = document.getElementById('signIn');
const container = document.getElementById('container');

signUpButton.addEventListener('click', () => {
	container.classList.add("right-panel-active");
});

signInButton.addEventListener('click', () => {
	container.classList.remove("right-panel-active");
});

document.addEventListener("DOMContentLoaded", function () {
	const formRegistro = document.getElementById("form-registro");
	const mensajeAjax = document.getElementById("mensaje-ajax"); // único p dinámico

	if (!formRegistro) {
		console.error("⚠️ No se encontró el formulario de registro.");
		return;
	}

	formRegistro.addEventListener("submit", function (e) {
		e.preventDefault(); // Evita recarga
		console.log("✅ Se interceptó el submit del formulario.");

		// Limpiar mensaje previo
		mensajeAjax.textContent = "";
		mensajeAjax.className = "";

		const datos = new FormData(formRegistro);

		fetch("ajax.php", {
			method: "POST",
			body: datos
		})
			.then(res => res.json())
			.then(data => {
				console.log("📩 Respuesta AJAX:", data);

				if (data.mensaje && data.clase) {
					mensajeAjax.textContent = data.mensaje;
					mensajeAjax.classList.add(data.clase);

					if (data.clase === "mensaje-exito") {
						formRegistro.reset();
					}
				} else {
					mensajeAjax.textContent = "Respuesta inesperada del servidor.";
					mensajeAjax.classList.add("mensaje-error");
				}
			})
			.catch(err => {
				console.error("❌ Error AJAX:", err);
				mensajeAjax.textContent = "Error de conexión.";
				mensajeAjax.classList.add("mensaje-error");
			});
	});
});