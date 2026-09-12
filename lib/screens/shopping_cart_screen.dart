import 'package:flutter/material.dart';
import '../models/product.dart';
import '../widgets/cart_summary.dart';
import '../widgets/product_card.dart';

class ShoppingCartScreen extends StatefulWidget {
  const ShoppingCartScreen({super.key});

  @override
  State<ShoppingCartScreen> createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen> {
  // Raw product data as specified in assignment requirements
  static const List<Map<String, dynamic>> rawProducts = [
    {"name": "T-Shirt", "price": 500, "category": "Clothes"},
    {"name": "Shoes", "price": 1500, "category": "Fashion"},
    {"name": "Watch", "price": 2000, "category": "Accessories"},
    {"name": "Bag", "price": 1000, "category": "Fashion"},
  ];

  late final List<Product> _products;

  static const List<String> _categories = [
    "All",
    "Clothes",
    "Fashion",
    "Accessories",
  ];

  String _selectedCategory = "All";
  String _searchQuery = "";
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _products = rawProducts.map((map) => Product.fromMap(map)).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Filter products by category & case-insensitive search
  List<Product> get _filteredProducts {
    return _products.where((product) {
      final matchesCategory = _selectedCategory == "All" ||
          product.category == _selectedCategory;
      final matchesSearch = product.name
          .toLowerCase()
          .contains(_searchQuery.toLowerCase().trim());
      return matchesCategory && matchesSearch;
    }).toList();
  }

  // Cart Calculations
  int get _totalItems =>
      _products.fold(0, (sum, item) => sum + item.quantity);

  double get _subtotal =>
      _products.fold(0.0, (sum, item) => sum + (item.price * item.quantity));

  double get _discount =>
      _subtotal >= 3000 ? _subtotal * 0.10 : 0.0;

  double get _grandTotal => _subtotal - _discount;

  void _incrementQuantity(Product product) {
    setState(() {
      product.quantity++;
    });
  }

  void _decrementQuantity(Product product) {
    if (product.quantity > 0) {
      setState(() {
        product.quantity--;
      });
    }
  }

  void _resetCart() {
    setState(() {
      for (var product in _products) {
        product.quantity = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final filteredList = _filteredProducts;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Simple Shopping Cart",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        centerTitle: true,
        actions: [
          if (_totalItems > 0)
            IconButton(
              icon: const Icon(Icons.refresh),
              tooltip: "Reset Cart",
              onPressed: _resetCart,
            ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Search Field and Category Dropdown Header
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  // Search Field
                  TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: "Search products by name...",
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: _searchQuery.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                setState(() {
                                  _searchController.clear();
                                  _searchQuery = "";
                                });
                              },
                            )
                          : null,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value;
                      });
                    },
                  ),
                  const SizedBox(height: 10),

                  // Category Dropdown
                  Row(
                    children: [
                      const Text(
                        "Category: ",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade400),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: _selectedCategory,
                              isExpanded: true,
                              items: _categories.map((String category) {
                                return DropdownMenuItem<String>(
                                  value: category,
                                  child: Text(category),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                if (newValue != null) {
                                  setState(() {
                                    _selectedCategory = newValue;
                                  });
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const Divider(height: 1),

            // Product List
            Expanded(
              child: filteredList.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.search_off,
                            size: 64,
                            color: Colors.grey.shade400,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            "No products found",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: filteredList.length,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      itemBuilder: (context, index) {
                        final product = filteredList[index];
                        return ProductCard(
                          product: product,
                          onIncrement: () => _incrementQuantity(product),
                          onDecrement: () => _decrementQuantity(product),
                        );
                      },
                    ),
            ),

            // Cart Summary
            CartSummary(
              totalItems: _totalItems,
              subtotal: _subtotal,
              discount: _discount,
              grandTotal: _grandTotal,
            ),
          ],
        ),
      ),
    );
  }
}
