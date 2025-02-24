 // JavaScript to handle the mobile menu toggle
        const mobileMenuButton = document.getElementById('mobile-menu-button');
        const closeMobileMenuButton = document.getElementById('close-mobile-menu-button');
        const mobileMenu = document.getElementById('mobile-menu');

        mobileMenuButton.addEventListener('click', () => {
            mobileMenu.classList.add('open'); // Show the mobile menu
        });

        closeMobileMenuButton.addEventListener('click', () => {
            mobileMenu.classList.remove('open'); // Hide the mobile menu
        });

        // JavaScript to handle navbar scroll behavior
        const header = document.querySelector('header');
        window.addEventListener('scroll', () => {
            if (window.innerWidth >= 1024) { // Only apply to non-mobile devices
                if (window.scrollY > 50) {
                    header.classList.add('scrolled');
                } else {
                    header.classList.remove('scrolled');
                }
            }
        });