// Tailwind Configuration for Custom Colors
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
            },
            fontFamily: {
                'sans': ['Inter', 'system-ui', 'sans-serif']
            }
        }
    }
};

// ===== MOBILE MENU FUNCTIONALITY =====
function toggleMobileMenu() {
    const menu = document.getElementById('mobileMenu');
    menu.classList.toggle('hidden');

    // Cierra el scroll detrás del menú (mejor UX en mobile)
    if (!menu.classList.contains('hidden')) {
        document.body.style.overflow = 'hidden';
    } else {
        document.body.style.overflow = '';
    }
}

// ===== LOGIN REDIRECT =====
function redirectToLogin() {
    // Ajusta la ruta según tu proyecto
    window.location.href = "login.html";
}

// ===== SCROLL TO SECTION =====
function scrollToSection(sectionId) {
    const element = document.getElementById(sectionId);
    if (element) {
        element.scrollIntoView({ behavior: "smooth", block: "start" });
    }
}

// ===== SCROLL TO TOP =====
const scrollToTopBtn = document.getElementById("scrollToTop");

function handleScroll() {
    // Mostrar/ocultar botón "scroll to top"
    if (window.scrollY > 150) {
        scrollToTopBtn.classList.remove("opacity-0", "invisible");
        scrollToTopBtn.classList.add("opacity-100", "visible");
    } else {
        scrollToTopBtn.classList.add("opacity-0", "invisible");
        scrollToTopBtn.classList.remove("opacity-100", "visible");
    }

    // Ocultar/mostrar header al hacer scroll
    const header = document.querySelector("header");
    if (!header.dataset.lastScroll) header.dataset.lastScroll = 0;

    if (window.scrollY > header.dataset.lastScroll && window.scrollY > 100) {
        header.style.transform = "translateY(-100%)";
    } else {
        header.style.transform = "translateY(0)";
    }

    header.dataset.lastScroll = window.scrollY;
}

if (scrollToTopBtn) {
    scrollToTopBtn.addEventListener("click", () => {
        window.scrollTo({ top: 0, behavior: "smooth" });
    });
}

// ===== FADE-IN ANIMATIONS =====
const observerOptions = { threshold: 0.1 };
const fadeInObserver = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
        if (entry.isIntersecting) {
            entry.target.classList.add("visible");
        }
    });
}, observerOptions);

// ===== INIT =====
document.addEventListener("DOMContentLoaded", () => {
    // Activar animaciones fade-in
    document.querySelectorAll(".fade-in").forEach(el => {
        fadeInObserver.observe(el);
    });

    // Cerrar menú móvil al hacer clic en links
    document.querySelectorAll("#mobileMenu a").forEach(link => {
        link.addEventListener("click", () => {
            document.getElementById("mobileMenu").classList.add("hidden");
            document.body.style.overflow = "";
        });
    });
});

// Listener de scroll optimizado
window.addEventListener("scroll", handleScroll);