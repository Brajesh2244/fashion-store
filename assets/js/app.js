// =========================================================
// LUXE NEUMORPHIC E-COMMERCE CLIENT APP ENGINE (app.js)
// Powering the Interactive Vercel Showcase
// =========================================================

const App = {
    // ---------------------------------------------
    // CART STATE MANAGEMENT (localStorage)
    // ---------------------------------------------
    getCart() {
        try {
            return JSON.parse(localStorage.getItem('fs_cart')) || [];
        } catch (e) {
            return [];
        }
    },

    saveCart(cart) {
        localStorage.setItem('fs_cart', JSON.stringify(cart));
        this.updateCartBadge();
    },

    addToCart(productId, variantId, quantity = 1) {
        const product = PRODUCTS.find(p => p.id === Number(productId));
        if (!product) return false;

        const variant = product.variants.find(v => v.id === Number(variantId)) || product.variants[0] || { id: 1, size: 'M' };
        let cart = this.getCart();

        const existingIndex = cart.findIndex(item => item.productId === product.id && item.variantId === variant.id);
        if (existingIndex > -1) {
            cart[existingIndex].quantity += Number(quantity);
        } else {
            cart.push({
                cartItemId: Date.now() + Math.floor(Math.random() * 1000),
                productId: product.id,
                name: product.name,
                brand: product.brand,
                price: product.price,
                imageUrl: product.imageUrl,
                variantId: variant.id,
                size: variant.size,
                quantity: Number(quantity)
            });
        }

        this.saveCart(cart);
        this.showToast(`✓ Added "${product.name}" (Size: ${variant.size}) to your Cart!`);
        return true;
    },

    updateCartQuantity(cartItemId, newQty) {
        let cart = this.getCart();
        const item = cart.find(i => i.cartItemId === Number(cartItemId));
        if (item) {
            item.quantity = Math.max(1, Number(newQty));
            this.saveCart(cart);
        }
    },

    removeFromCart(cartItemId) {
        let cart = this.getCart();
        cart = cart.filter(i => i.cartItemId !== Number(cartItemId));
        this.saveCart(cart);
        this.showToast('Item removed from cart.');
    },

    getCartTotal() {
        const cart = this.getCart();
        return cart.reduce((sum, item) => sum + (item.price * item.quantity), 0);
    },

    clearCart() {
        localStorage.removeItem('fs_cart');
        this.updateCartBadge();
    },

    updateCartBadge() {
        const cart = this.getCart();
        const totalItems = cart.reduce((count, item) => count + item.quantity, 0);
        document.querySelectorAll('.cart-badge').forEach(badge => {
            if (totalItems > 0) {
                badge.textContent = totalItems;
                badge.style.display = 'inline-block';
            } else {
                badge.style.display = 'none';
            }
        });
    },

    // ---------------------------------------------
    // ORDERS MANAGEMENT (localStorage)
    // ---------------------------------------------
    getOrders() {
        try {
            return JSON.parse(localStorage.getItem('fs_orders')) || [
                {
                    orderId: 1001,
                    orderDate: "2026-10-04 14:30:00",
                    totalAmount: 3298.00,
                    shippingAddress: "Flat 402, Luxury Towers, Indiranagar, Bangalore - 560038",
                    paymentMethod: "UPI",
                    status: "Delivered",
                    items: [
                        { name: "Black Casual Shirt", brand: "Roadster", size: "M", price: 1299.00, quantity: 1, imageUrl: "assets/images/products/black-casual-shirt.jpg" },
                        { name: "Blue Slim Fit Jeans", brand: "Levis", size: "32", price: 1999.00, quantity: 1, imageUrl: "assets/images/products/blue-slim-fit-jeans.jpg" }
                    ]
                }
            ];
        } catch (e) {
            return [];
        }
    },

    saveOrder(order) {
        const orders = this.getOrders();
        orders.unshift(order);
        localStorage.setItem('fs_orders', JSON.stringify(orders));
    },

    // ---------------------------------------------
    // USER PROFILE
    // ---------------------------------------------
    getUser() {
        try {
            return JSON.parse(localStorage.getItem('fs_user')) || {
                fullName: "Brajesh Sharma",
                email: "brajesh@fashionstore.com",
                phone: "+91 98765 43210",
                address: "Flat 402, Luxury Towers, Indiranagar",
                city: "Bengaluru",
                state: "Karnataka",
                pincode: "560038"
            };
        } catch (e) {
            return { fullName: "Guest User", email: "guest@fashionstore.com", phone: "+91 98765 43210" };
        }
    },

    saveUser(user) {
        localStorage.setItem('fs_user', JSON.stringify(user));
        this.showToast('Profile updated successfully!');
    },

    // ---------------------------------------------
    // TOAST NOTIFICATIONS
    // ---------------------------------------------
    showToast(message) {
        let toast = document.getElementById('fs-toast');
        if (!toast) {
            toast = document.createElement('div');
            toast.id = 'fs-toast';
            toast.style.cssText = `
                position: fixed;
                bottom: 30px;
                right: 30px;
                background: linear-gradient(135deg, var(--color-accent, #c8a96a), #b3924f);
                color: #ffffff;
                padding: 14px 24px;
                border-radius: 50px;
                box-shadow: 0 8px 24px rgba(0,0,0,0.25);
                font-weight: 700;
                font-size: 14px;
                z-index: 99999;
                display: flex;
                align-items: center;
                gap: 10px;
                transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
                opacity: 0;
                transform: translateY(20px);
            `;
            document.body.appendChild(toast);
        }
        toast.innerHTML = `<i class="fa-solid fa-circle-check"></i> <span>${message}</span>`;
        toast.style.opacity = '1';
        toast.style.transform = 'translateY(0)';

        clearTimeout(this._toastTimeout);
        this._toastTimeout = setTimeout(() => {
            toast.style.opacity = '0';
            toast.style.transform = 'translateY(20px)';
        }, 3200);
    },

    // ---------------------------------------------
    // INITIALIZATION
    // ---------------------------------------------
    init() {
        // Theme initialization
        const storedTheme = localStorage.getItem('fs_theme');
        if (storedTheme === 'dark' || (!storedTheme && window.matchMedia('(prefers-color-scheme: dark)').matches)) {
            document.body.classList.add('dark-mode');
            document.documentElement.classList.add('dark-mode');
        }

        // Theme Toggle Button
        const themeBtn = document.getElementById('themeToggleBtn');
        if (themeBtn) {
            themeBtn.addEventListener('click', (e) => {
                e.preventDefault();
                document.body.classList.toggle('dark-mode');
                document.documentElement.classList.toggle('dark-mode');
                const isDark = document.body.classList.contains('dark-mode');
                localStorage.setItem('fs_theme', isDark ? 'dark' : 'light');
            });
        }

        // Mobile Nav Toggle
        const mobileBtn = document.getElementById('mobileMenuBtn');
        const navLinks = document.getElementById('navLinks');
        if (mobileBtn && navLinks) {
            mobileBtn.addEventListener('click', () => {
                navLinks.classList.toggle('active');
            });
        }

        // Sync badge
        this.updateCartBadge();
    }
};

document.addEventListener('DOMContentLoaded', () => App.init());
