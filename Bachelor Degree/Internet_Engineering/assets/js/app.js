// ============================================================
// Data — product catalog
// ============================================================

const PRODUCTS = [
    // Woman
    { id: 1, name: 'Women Ethnic', color: 'White', price: 49000, img: 'assets/img/women/women.png', desc: 'A beautiful ethnic dress crafted from premium fabric, perfect for special occasions and festive gatherings.' },
    { id: 2, name: 'Women Weston', color: 'Red', price: 62000, img: 'assets/img/women/women2.jpg', desc: 'Modern western-style outfit combining elegance and comfort for the everyday woman.' },
    { id: 3, name: 'Goggles', color: 'Brown', price: 18000, img: 'assets/img/women/women3.jpg', desc: 'Trendy UV-protection goggles that complement any outfit while keeping your eyes safe in style.' },
    { id: 4, name: 'Women Ethnic', color: 'Yellow', price: 55000, img: 'assets/img/women/women4.jpg', desc: 'Vibrant yellow ethnic collection that celebrates traditional craftsmanship with a modern twist.' },
    // Man
    { id: 5, name: 'Casual Wear', color: 'Mixed', price: 38000, img: 'assets/img/shirt/shirt.png', desc: 'Comfortable everyday casual wear made from breathable cotton, ideal for a relaxed yet stylish look.' },
    { id: 6, name: 'Printed Shirt', color: 'Multi', price: 44000, img: 'assets/img/shirt/shirt2.png', desc: 'Bold printed shirt with high-quality dye that stays vibrant after every wash — stand out from the crowd.' },
    { id: 7, name: 'Women Shirts', color: 'White', price: 41000, img: 'assets/img/shirt/shirt3.png', desc: 'Classic slim-fit shirt suitable for both formal meetings and casual outings — a wardrobe essential.' },
];

// Format price in Tomans
function formatPrice(p) {
    return p.toLocaleString('en-US') + ' T';
}

// ============================================================
// Cart State
// ============================================================

let cart = [];

function cartTotal() {
    return cart.reduce((sum, item) => sum + item.price * item.qty, 0);
}

function addToCart(productId) {
    const product = PRODUCTS.find(p => p.id === productId);
    if (!product) return;

    const existing = cart.find(i => i.id === productId);
    if (existing) {
        existing.qty++;
    } else {
        cart.push({ ...product, qty: 1 });
    }

    updateCartUI();
    showNotif(`${product.name} added to cart`);
}

function removeFromCart(productId) {
    cart = cart.filter(i => i.id !== productId);
    updateCartUI();
}

function changeQty(productId, delta) {
    const item = cart.find(i => i.id === productId);
    if (!item) return;
    item.qty += delta;
    if (item.qty <= 0) removeFromCart(productId);
    else updateCartUI();
}

// ============================================================
// Cart UI
// ============================================================

function updateCartUI() {
    const count = cart.reduce((s, i) => s + i.qty, 0);
    const badge = document.getElementById('cartBadge');
    const list = document.getElementById('cartItemsList');
    const total = document.getElementById('cartTotal');

    // Badge
    badge.textContent = count;
    badge.classList.toggle('visible', count > 0);

    // Items list
    if (cart.length === 0) {
        list.innerHTML = `
      <div class="cart-empty">
        <i class="bi bi-bag-x"></i>
        <p>Your cart is empty</p>
      </div>`;
    } else {
        list.innerHTML = cart.map(item => `
      <div class="cart-item">
        <div class="cart-item-img-placeholder overflow-hidden">
            <img src="${item.img}" alt="${item.name}" class="w-100 h-100 object-fit-cover">
        </div>
        <div class="cart-item-info">
          <div class="cart-item-name">${item.name}</div>
          <div class="cart-item-color">${item.color}</div>
          <div class="cart-item-qty">
            <button class="qty-btn" onclick="changeQty(${item.id}, -1)">−</button>
            <span class="qty-value">${item.qty}</span>
            <button class="qty-btn" onclick="changeQty(${item.id}, +1)">+</button>
          </div>
        </div>
        <div class="cart-item-price">${formatPrice(item.price * item.qty)}</div>
        <button class="cart-item-remove" onclick="removeFromCart(${item.id})">
          <i class="bi bi-x-lg"></i>
        </button>
      </div>
    `).join('');
    }

    // Total
    total.textContent = formatPrice(cartTotal());
}

// ============================================================
// Cart Sidebar open / close
// ============================================================

function openCart() {
    document.getElementById('cartOverlay').classList.add('open');
    document.getElementById('cartSidebar').classList.add('open');
    document.body.style.overflow = 'hidden';
}

function closeCart() {
    document.getElementById('cartOverlay').classList.remove('open');
    document.getElementById('cartSidebar').classList.remove('open');
    document.body.style.overflow = '';
}

// ============================================================
// Product Modal
// ============================================================

function openProductModal(productId) {
    const p = PRODUCTS.find(pr => pr.id === productId);
    if (!p) return;

    const imgEl = document.getElementById('modalImg');
    imgEl.src = p.img;
    imgEl.alt = p.name;

    document.getElementById('modalTitle').textContent = p.name;
    document.getElementById('modalColor').textContent = p.color;
    document.getElementById('modalPrice').textContent = formatPrice(p.price);
    document.getElementById('modalDesc').textContent = p.desc;
    document.getElementById('modalAddBtn').onclick = () => { addToCart(p.id); closeProductModal(); };

    document.getElementById('productModalOverlay').classList.add('open');
    document.body.style.overflow = 'hidden';
}

function closeProductModal() {
    document.getElementById('productModalOverlay').classList.remove('open');
    document.body.style.overflow = '';
}

// ============================================================
// Notification
// ============================================================

let NotifTimer;

function showNotif(msg) {
    const Notif = document.getElementById('cartNotif');
    Notif.querySelector('span').textContent = msg;
    Notif.classList.add('show');
    clearTimeout(NotifTimer);
    NotifTimer = setTimeout(() => Notif.classList.remove('show'), 1000);
}

// ============================================================
// Theme Toggle
// ============================================================

const themeBtn = document.getElementById('customThemeBtn');
const navbar = document.getElementById('customNavbar');
const body = document.body;

// Restore saved theme
if (localStorage.getItem('theme') === 'dark') {
    body.classList.add('dark-mode');
    navbar.classList.add('dark-mode');
    themeBtn.innerHTML = '☀️';
}

themeBtn.addEventListener('click', () => {
    const isDark = body.classList.toggle('dark-mode');
    navbar.classList.toggle('dark-mode', isDark);
    themeBtn.innerHTML = isDark ? '☀️' : '🌙';
    localStorage.setItem('theme', isDark ? 'dark' : 'light');
});

// ============================================================
// Footer Visibility Animation
// ============================================================

function checkFooterVisibility() {
    const footer = document.querySelector('footer');
    const rect = footer.getBoundingClientRect();
    const windowHeight = window.innerHeight;

    if (rect.top <= windowHeight - 50 && rect.bottom >= 0) {
        footer.classList.add('show');
    } else {
        footer.classList.remove('show');
    }
}

window.addEventListener('scroll', checkFooterVisibility);
window.addEventListener('resize', checkFooterVisibility);
document.addEventListener('DOMContentLoaded', checkFooterVisibility);