# 🛍️ SHOP — E-Commerce Front-End

A modern and responsive **e-commerce website** built with **HTML, CSS, JavaScript, Bootstrap, and Bootstrap Icons**.

This project is a front-end shopping website that includes product categories, product details, a shopping cart, dark mode, login page, and responsive design.

---

## 🛠️ Technologies

* **HTML5**
* **CSS3**
* **JavaScript (Vanilla JS)**
* **Bootstrap 5**
* **Bootstrap Icons**
* **LocalStorage**

No backend or database is currently used.

---

## 📂 Project Structure

```text
SHOP/
│
├── index.html
├── login.html
├── README.md
│
└── assets/
    │
    ├── css/
    │   ├── app.css
    │   └── bootstrap.min.css
    │
    ├── js/
    │   ├── app.js
    │   └── bootstrap.bundle.min.js
    │
    └── img/
        ├── hero/
        │   ├── sale.png
        │   └── shopping.png
        │
        ├── women/
        │   ├── women.png
        │   ├── women2.jpg
        │   ├── women3.jpg
        │   └── women4.jpg
        │
        └── shirt/
            ├── shirt.png
            ├── shirt2.png
            └── shirt3.png
```

---

## 🛒 Shopping Cart

The shopping cart is implemented using JavaScript.

Users can:

* Add products to the cart
* Increase product quantity
* Decrease product quantity
* Remove products
* View the total price
* View the total number of products
* Open and close the cart sidebar

The cart state is currently stored **in memory** and will reset after refreshing the page.

---

## 🌙 Dark Mode

The website includes a dark/light mode switch.

The selected theme is saved using:

```javascript
localStorage.setItem("theme", "dark");
```

This allows the website to remember the user's theme preference after refreshing the page.

The same theme system is also implemented on the login page.

---

## 🔐 Login Page

The project includes a separate login page with:

* Email input
* Password input
* Remember me checkbox
* Forgot password link
* Social login buttons
* Sign up link
* Dark mode

> **Note:** The login system is currently UI-only. No authentication or backend functionality has been implemented yet.

---

## 📦 Product Data

Products are currently stored inside `app.js` using a JavaScript array:

```javascript
const PRODUCTS = [
    {
        id: 1,
        name: "Women Ethnic",
        color: "White",
        price: 49000,
        img: "assets/img/women/women.png",
        desc: "A beautiful ethnic dress..."
    }
];
```

This makes it easy to add or modify products without changing the HTML structure.

---


## 📸 Pages

### Home Page

The main page contains:

* Navigation bar
* Hero section
* Women's products
* Men's products
* About Us
* Footer
* Shopping cart

### Login Page

A separate login interface is available at:

```text
login.html
```


