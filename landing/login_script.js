// Wait for DOM to be fully loaded
document.addEventListener('DOMContentLoaded', function() {
    // Tailwind Configuration
    if (typeof tailwind !== 'undefined') {
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        'tierra-oscuro': '#8B4513',
                        'tierra-medio': '#CD853F',
                        'tierra-claro': '#DEB887',
                        'verde-artesanal': '#6B8E23',
                        'naranja-artesanal': '#D2691E',
                        'beige-suave': '#F5F5DC'
                    }
                }
            }
        };
    }

    // Get form elements
    const loginForm = document.getElementById('loginForm');
    const registerForm = document.getElementById('registerForm');
    const showRegisterBtn = document.getElementById('showRegister');
    const showLoginBtn = document.getElementById('showLogin');

    // Form switching functionality
    function showRegisterForm() {
        if (loginForm && registerForm) {
            // Hide login form
            loginForm.classList.add('slide-exit');
            
            setTimeout(() => {
                loginForm.style.display = 'none';
                registerForm.style.display = 'grid';
                registerForm.classList.remove('slide-enter');
                registerForm.classList.add('active');
            }, 300);
        }
    }

    function showLoginForm() {
        if (loginForm && registerForm) {
            // Hide register form
            registerForm.classList.remove('active');
            registerForm.classList.add('slide-enter');
            
            setTimeout(() => {
                registerForm.style.display = 'none';
                loginForm.style.display = 'grid';
                loginForm.classList.remove('slide-exit');
            }, 300);
        }
    }

    // Event listeners for form switching
    if (showRegisterBtn) {
        showRegisterBtn.addEventListener('click', showRegisterForm);
    }
    
    if (showLoginBtn) {
        showLoginBtn.addEventListener('click', showLoginForm);
    }

    // Password validation function
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

    // Function to show messages
    function showMessage(elementId, message, type) {
        const messageEl = document.getElementById(elementId);
        if (messageEl) {
            messageEl.textContent = message;
            messageEl.className = `text-sm text-center py-2 px-4 rounded-lg border ${type === 'success' ? 'message-success' : 'message-error'}`;
            messageEl.classList.remove('hidden');
            
            // Auto-hide success messages after 5 seconds
            if (type === 'success') {
                setTimeout(() => {
                    messageEl.classList.add('hidden');
                }, 5000);
            }
        }
    }

    // Registration form handler
    const formRegistro = document.getElementById('form-registro');
    if (formRegistro) {
        formRegistro.addEventListener('submit', function(e) {
            e.preventDefault();
            
            const contrasena = this.querySelector('input[name="contrasena"]').value;
            const errorContrasena = validarContrasena(contrasena);
            
            if (errorContrasena) {
                showMessage('mensaje-ajax', errorContrasena, 'error');
                return;
            }

            const datos = new FormData(this);
            datos.append("accion", "registro");

            // Show loading state
            const submitBtn = this.querySelector('button[type="submit"]');
            const originalText = submitBtn.textContent;
            submitBtn.textContent = 'Creando cuenta...';
            submitBtn.disabled = true;

            // Simulate API call
            setTimeout(() => {
                showMessage('mensaje-ajax', 'Cuenta creada exitosamente. ¡Bienvenido a VIVA!', 'success');
                this.reset();
                
                // Reset button
                submitBtn.textContent = originalText;
                submitBtn.disabled = false;
                
                // Optionally switch to login form after successful registration
                setTimeout(() => {
                    showLoginForm();
                }, 2000);
                
            }, 1500);

            /* Uncomment for real implementation
            fetch("ajax.php", {
                method: "POST",
                body: datos
            })
            .then(res => res.json())
            .then(data => {
                showMessage('mensaje-ajax', data.mensaje, data.clase === 'mensaje-exito' ? 'success' : 'error');
                if (data.clase === "mensaje-exito") {
                    this.reset();
                    setTimeout(() => {
                        showLoginForm();
                    }, 2000);
                }
            })
            .catch(err => {
                showMessage('mensaje-ajax', 'Error de conexión.', 'error');
                console.error('Error:', err);
            })
            .finally(() => {
                submitBtn.textContent = originalText;
                submitBtn.disabled = false;
            });
            */
        });
    }

    // Login form handler
    const formLogin = document.getElementById('form-login');
    if (formLogin) {
        formLogin.addEventListener('submit', function(e) {
            e.preventDefault();
            
            const datos = new FormData(this);
            datos.append("accion", "login");

            // Show loading state
            const submitBtn = this.querySelector('button[type="submit"]');
            const originalText = submitBtn.textContent;
            submitBtn.textContent = 'Iniciando sesión...';
            submitBtn.disabled = true;

            // Simulate API call
            setTimeout(() => {
                showMessage('mensaje-login', 'Sesión iniciada correctamente. Redirigiendo...', 'success');
                this.reset();
                
                // Reset button
                submitBtn.textContent = originalText;
                submitBtn.disabled = false;
                
                setTimeout(() => {
                    window.location.href = "index.html";
                }, 1500);
            }, 1500);

            /* Uncomment for real implementation
            fetch("ajax.php", {
                method: "POST",
                body: datos
            })
            .then(res => res.json())
            .then(data => {
                showMessage('mensaje-login', data.mensaje, data.clase === 'mensaje-exito' ? 'success' : 'error');
                if (data.clase === "mensaje-exito") {
                    this.reset();
                    setTimeout(() => {
                        window.location.href = "index.html";
                    }, 1500);
                }
            })
            .catch(err => {
                showMessage('mensaje-login', 'Error de conexión.', 'error');
                console.error('Error:', err);
            })
            .finally(() => {
                submitBtn.textContent = originalText;
                submitBtn.disabled = false;
            });
            */
        });
    }

    // Password visibility toggle functionality
    const passwordToggles = document.querySelectorAll('.password-toggle');
    
    passwordToggles.forEach(toggle => {
        toggle.addEventListener('click', function() {
            // Find the input field that's in the same container as this button
            const input = this.parentElement.querySelector('input[type="password"], input[type="text"]');
            const icon = this.querySelector('i');
            
            if (input && icon) {
                if (input.type === 'password') {
                    // Show password
                    input.type = 'text';
                    icon.classList.remove('fa-eye');
                    icon.classList.add('fa-eye-slash');
                } else {
                    // Hide password
                    input.type = 'password';
                    icon.classList.remove('fa-eye-slash');
                    icon.classList.add('fa-eye');
                }
            }
        });
    });

    // Initialize forms properly
    if (registerForm) {
        registerForm.style.display = 'none';
    }
    
    // Handle form validation on input
    const emailInputs = document.querySelectorAll('input[type="email"]');
    emailInputs.forEach(input => {
        input.addEventListener('blur', function() {
            const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (this.value && !emailPattern.test(this.value)) {
                this.style.borderColor = '#dc2626';
            } else {
                this.style.borderColor = '';
            }
        });
    });
    
    // Clear messages when switching forms
    function clearMessages() {
        const messages = document.querySelectorAll('#mensaje-login, #mensaje-ajax');
        messages.forEach(msg => {
            if (msg) {
                msg.classList.add('hidden');
            }
        });
    }
    
    // Update the form switching functions to clear messages
    const originalShowRegister = showRegisterBtn?.onclick;
    const originalShowLogin = showLoginBtn?.onclick;
    
    if (showRegisterBtn) {
        showRegisterBtn.addEventListener('click', clearMessages);
    }
    
    if (showLoginBtn) {
        showLoginBtn.addEventListener('click', clearMessages);
    }
});