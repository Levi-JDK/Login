document.addEventListener("DOMContentLoaded", function () {
    const userSection = document.getElementById("user-section");

    // Verificar sesión
    fetch("check_session.php", {
        method: "GET",
        credentials: "same-origin" // Para incluir cookies/sesiones
    })
    .then(response => response.json())
    .then(data => {
        if (data.loggedIn) {
            // Mostrar nombre de usuario
            userSection.innerHTML = `<span class="user-name">${data.nombre}</span> <a href="logout.php" class="btn-logout">Cerrar Sesión</a>`;
        } else {
            // Mostrar botón de login
            userSection.innerHTML = `<a href="login.html" class="btn-login">Iniciar Sesión</a>`;
        }
    })
    .catch(error => {
        console.error("Error al verificar sesión:", error);
        userSection.innerHTML = `<a href="login.html" class="btn-login">Iniciar Sesión</a>`;
    });
});