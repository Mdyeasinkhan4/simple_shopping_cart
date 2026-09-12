# 🛒 Simple Shopping Cart Application

A modern, responsive, and lightweight Flutter shopping cart application built for product browsing, interactive quantity selection, instant search, category filtering, and real-time cart total & discount calculations.

---

## 📸 App Screenshots & Preview

| Home Screen | Cart & Auto Discount | Category Menu |
| :---: | :---: | :---: |
| <img src="https://github.com/Mdyeasinkhan4/simple_shopping_cart/raw/0ba1161f8c95cec54e2c1fadfcc583267e76bcaf/preview_images/01.HomeSC.png" width="250"/> | <img src="https://github.com/Mdyeasinkhan4/simple_shopping_cart/raw/0ba1161f8c95cec54e2c1fadfcc583267e76bcaf/preview_images/02.menu_with_cart_priceSC.png" width="250"/> | <img src="https://github.com/Mdyeasinkhan4/simple_shopping_cart/raw/0ba1161f8c95cec54e2c1fadfcc583267e76bcaf/preview_images/03.filterSC.png" width="250"/> |
| Initial Product List | Cart Summary & 10% Discount | Category Selection Dropdown |

| Clothes Filter | Fashion Filter | Accessories Filter | Search Product |
| :---: | :---: | :---: | :---: |
| <img src="https://github.com/Mdyeasinkhan4/simple_shopping_cart/raw/0ba1161f8c95cec54e2c1fadfcc583267e76bcaf/preview_images/04.clothesfilterSC.png" width="220"/> | <img src="https://github.com/Mdyeasinkhan4/simple_shopping_cart/raw/0ba1161f8c95cec54e2c1fadfcc583267e76bcaf/preview_images/05.fashionfilterSC.png" width="220"/> | <img src="https://github.com/Mdyeasinkhan4/simple_shopping_cart/raw/0ba1161f8c95cec54e2c1fadfcc583267e76bcaf/preview_images/06.accessoriesfilterSC.png" width="220"/> | <img src="https://github.com/Mdyeasinkhan4/simple_shopping_cart/raw/0ba1161f8c95cec54e2c1fadfcc583267e76bcaf/preview_images/07.SearchSC.png" width="220"/> |
| Clothes Category | Fashion Category | Accessories Category | Instant Product Search |

---

## ✨ Features

- 🛍️ **Product Catalog**: Displays products with category badges, price tags, and interactive quantity selectors.
- ➕➖ **Quantity Control**:
  - `+` increases item count.
  - `-` decreases item count (guarded so quantity never drops below `0`).
  - Quantities initialize at `0`.
- 🧮 **Real-time Cart Calculations**:
  - **Total Items**: Sum of quantities across all items.
  - **Subtotal**: Total price calculated instantly (`price × quantity`).
  - **Automatic Discount**: **10% discount** automatically applied whenever Subtotal is **৳3,000 or more**.
  - **Grand Total**: Subtotal minus applied discount.
- 🔍 **Case-Insensitive Search**: Search products dynamically by name with an instant clear button.
- 🏷️ **Category Filter**: Filter product items by `All`, `Clothes`, `Fashion`, or `Accessories`.
- 🔄 **Combined Search & Filter**: Search field and dropdown category selection seamlessly work together.
- 🚫 **Empty State Handling**: Friendly UI message displayed when search or category yields no matching products.
- ♻️ **Reset Cart**: Quick reset option available in AppBar when items are added to cart.

---

## 🛠️ Architecture & Folder Structure

Built using a modular and maintainable folder structure separating models, screens, and reusable widgets:

```text
lib/
├── main.dart                      # Application Entry Point
├── models/
│   └── product.dart               # Product Data Model & Factory Constructor
├── screens/
│   └── shopping_cart_screen.dart # Main Screen with State & Search/Filter Logic
└── widgets/
    ├── cart_summary.dart          # Sticky Cart Calculation Summary Widget
    └── product_card.dart          # Reusable Product Card Widget with Quantity Controls
```

---

## 📐 Business Logic & Formulae

```text
Total Items = sum(product.quantity)

Subtotal = sum(product.price × product.quantity)

Discount = Subtotal >= ৳3,000 ? (Subtotal × 10%) : ৳0

Grand Total = Subtotal - Discount
```

### Example Calculation Scenario:
- **T-Shirt** (৳500 × 1) + **Shoes** (৳1500 × 1) + **Watch** (৳2000 × 1) = **Subtotal: ৳4,000**
- Since Subtotal (৳4,000) ≥ ৳3,000 👉 **Discount (10%): ৳400**
- **Grand Total**: ৳4,000 - ৳400 = **৳3,600**

---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (v3.13 or higher)
- Dart SDK
- Android Studio / VS Code with Flutter extension

### Installation & Execution

1. **Clone the repository**:
   ```bash
   git clone https://github.com/Mdyeasinkhan4/simple_shopping_cart.git
   cd simple_shopping_cart
   ```

2. **Get dependencies**:
   ```bash
   flutter pub get
   ```

3. **Run the application**:
   ```bash
   flutter run
   ```

4. **Run Unit & Widget Tests**:
   ```bash
   flutter test
   ```

---

## 📦 Tech Stack & Packages

- **Framework**: [Flutter](https://flutter.dev) (Material 3 Theme)
- **Language**: [Dart](https://dart.dev) (Null safety enabled)
- **State Management**: Clean Flutter `setState`
- **Testing**: `flutter_test` (Widget & Unit Tests)
