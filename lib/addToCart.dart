import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'cartProvider.dart';

class CartPage extends StatelessWidget {
  final List<Map<String, dynamic>> cartItems;

  CartPage({required this.cartItems});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shopping Cart"),
      ),
      body: Consumer<CartProvider>(
        builder: (context, cartProvider, child) {
          return ListView.builder(
            itemCount: cartItems.length,
            itemBuilder: (context, index) {
              final item = cartItems[index];
              return ProductCard(
                product: item,
                isInCart: true,
                removeFromCart: (product) {
                  cartProvider.removeFromCart(product);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Removed from Cart'),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      bottomNavigationBar: Consumer<CartProvider>(
        builder: (context, cartProvider, child) {
          return BottomAppBar(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total: \$${calculateTotal(cartProvider.cartItems)}',
                    style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Implement your checkout logic here
                      // For now, it just shows a snackbar
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Checkout button pressed'),
                        ),
                      );
                    },
                    child: Text('Checkout'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // Function to calculate the total price of items in the cart
  String calculateTotal(List<Map<String, dynamic>> items) {
    double total = 0;
    for (var item in items) {
      total += item['price'];
    }
    return total.toStringAsFixed(2);
  }
}

class ProductCard extends StatelessWidget {
  final Map<String, dynamic> product;
  final bool isInCart;
  final Function(Map<String, dynamic>) removeFromCart;

  ProductCard({
    required this.product,
    required this.isInCart,
    required this.removeFromCart,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: Column(
        children: [
          Image.network(
            product['image'],
            height: 200.0,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product['name'],
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  product['description'],
                  style: TextStyle(fontSize: 14.0),
                ),
                Text(
                  '\$${product['price']}',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ),
          if (isInCart)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  // Call the provided removeFromCart callback
                  removeFromCart(product);
                },
                child: Text("Remove from Cart"),
              ),
            ),
        ],
      ),
    );
  }
}
