// ===== Navbar Scroll Effect =====
const navbar = document.getElementById('navbar');
window.addEventListener('scroll', () => {
    navbar.classList.toggle('scrolled', window.scrollY > 50);
});

// ===== Mobile Navigation Toggle =====
const navToggle = document.getElementById('nav-toggle');
const navLinks = document.getElementById('nav-links');

navToggle.addEventListener('click', () => {
    navLinks.classList.toggle('open');
    // Animate hamburger to X
    navToggle.classList.toggle('active');
});

// Close mobile menu on link click
document.querySelectorAll('.nav-links a').forEach(link => {
    link.addEventListener('click', () => {
        navLinks.classList.remove('open');
        navToggle.classList.remove('active');
    });
});

// ===== Active Navigation Link =====
const sections = document.querySelectorAll('section[id]');
const navItems = document.querySelectorAll('.nav-links a');

function updateActiveNav() {
    const scrollY = window.scrollY + 100;

    sections.forEach(section => {
        const top = section.offsetTop;
        const height = section.offsetHeight;
        const id = section.getAttribute('id');

        if (scrollY >= top && scrollY < top + height) {
            navItems.forEach(item => {
                item.classList.remove('active');
                if (item.getAttribute('href') === `#${id}`) {
                    item.classList.add('active');
                }
            });
        }
    });
}

window.addEventListener('scroll', updateActiveNav);
updateActiveNav();

// ===== Scroll Animations =====
function initScrollAnimations() {
    const animatedElements = document.querySelectorAll(
        '.skill-category, .project-card, .about-text, .contact-info, .contact-form, .about-stats .stat'
    );

    animatedElements.forEach(el => el.classList.add('fade-in'));

    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.classList.add('visible');
                observer.unobserve(entry.target);
            }
        });
    }, {
        threshold: 0.15,
        rootMargin: '0px 0px -50px 0px'
    });

    animatedElements.forEach(el => observer.observe(el));
}

initScrollAnimations();

// ===== Contact Form =====
const contactForm = document.getElementById('contact-form');
contactForm.addEventListener('submit', (e) => {
    e.preventDefault();

    const formData = new FormData(contactForm);
    const data = Object.fromEntries(formData);

    // Show success message
    const btn = contactForm.querySelector('button[type="submit"]');
    const originalText = btn.innerHTML;
    btn.innerHTML = '<i class="fas fa-check"></i> Đã gửi thành công!';
    btn.style.background = '#10b981';
    btn.style.borderColor = '#10b981';
    btn.disabled = true;

    setTimeout(() => {
        btn.innerHTML = originalText;
        btn.style.background = '';
        btn.style.borderColor = '';
        btn.disabled = false;
        contactForm.reset();
    }, 3000);

    console.log('Form data:', data);
});

// ===== Smooth Reveal for Hero =====
window.addEventListener('load', () => {
    document.querySelector('.hero-text').style.animation = 'fadeInUp 0.8s ease forwards';
    document.querySelector('.hero-image').style.animation = 'fadeInUp 0.8s 0.2s ease forwards';
});

// Add fadeInUp animation dynamically
const style = document.createElement('style');
style.textContent = `
    @keyframes fadeInUp {
        from { opacity: 0; transform: translateY(30px); }
        to { opacity: 1; transform: translateY(0); }
    }
    .hero-text, .hero-image {
        opacity: 0;
    }
`;
document.head.appendChild(style);
