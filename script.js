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
    const formLogin = document.getElementById("form-login");
    const mensajeAjax = document.getElementById("mensaje-ajax");
    const mensajeLogin = document.getElementById("mensaje-login");

    // Validación de contraseña en el frontend
    function validarContrasena(contrasena) {
        const minLength = 8;
        const hasUpperCase = /[A-Z]/.test(contrasena);
        const hasLowerCase = /[a-z]/.test(contrasena);
        const hasNumbers = /\d/.test(contrasena);
        const hasSpecialChar = /[!@#$%^&*(),.?":{}|<>]/.test(contrasena);

        if (contrasena.length < minLength) {
            return "La contraseña debe tener al menos 8 caracteres.";
        }
        if (!hasUpperCase || !hasLowerCase || !hasNumbers || !hasSpecialChar) {
            return "La contraseña debe incluir mayúsculas, minúsculas, números y caracteres especiales.";
        }
        return "";
    }

    // Registro
    if (formRegistro) {
        formRegistro.addEventListener("submit", function (e) {
            e.preventDefault();
            mensajeAjax.textContent = "";
            mensajeAjax.className = "";

            const contrasena = formRegistro.querySelector('input[name="contrasena"]').value;
            const errorContrasena = validarContrasena(contrasena);
            if (errorContrasena) {
                mensajeAjax.textContent = errorContrasena;
                mensajeAjax.classList.add("mensaje-error");
                return;
            }

            const datos = new FormData(formRegistro);
            datos.append("accion", "registro");

            fetch("ajax.php", {
                method: "POST",
                body: datos
            })
                .then(res => res.json())
                .then(data => {
                    if (data.mensaje && data.clase) {
                        mensajeAjax.textContent = data.mensaje;
                        mensajeAjax.classList.add(data.clase);
                        if (data.clase === "mensaje-exito") {
                            formRegistro.reset();
                        }
                    }
                })
                .catch(err => {
                    mensajeAjax.textContent = "Error de conexión.";
                    mensajeAjax.classList.add("mensaje-error");
                });
        });
    }

    // Login
    if (formLogin) {
        formLogin.addEventListener("submit", function (e) {
            e.preventDefault();
            mensajeLogin.textContent = "";
            mensajeLogin.className = "";

            const datos = new FormData(formLogin);
            datos.append("accion", "login");

            fetch("ajax.php", {
                method: "POST",
                body: datos
            })
                .then(res => res.json())
                .then(data => {
                    if (data.mensaje && data.clase) {
                        mensajeLogin.textContent = data.mensaje;
                        mensajeLogin.classList.add(data.clase);
                        if (data.clase === "mensaje-exito") {
                            formLogin.reset();
                            // Redirigir a una página después del login exitoso
                            setTimeout(() => {
                                window.location.href = "index.html"; 
                            }, 1000);
                        }
                    }
                })
                .catch(err => {
                    mensajeLogin.textContent = "Error de conexión.";
                    mensajeLogin.classList.add("mensaje-error");
                });
        });
    }
});