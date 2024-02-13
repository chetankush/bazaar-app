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
    return Container(
      height: 300.0,
      margin: EdgeInsets.all(10.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        elevation: 4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.0),
                topRight: Radius.circular(12.0),
              ),
              child: Container(
                height: 120.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(product['image']),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8.0),
                  Text(
                    product['name'],
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    product['description'],
                    style: TextStyle(fontSize: 14.0),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 8.0),
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
                child: ElevatedButton.icon(
                  onPressed: () {
                    // Call the provided removeFromCart callback
                    removeFromCart(product);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                  ),
                  icon: Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  label: Text(
                    "Remove from Cart",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

          ],
        ),
      ),
    );
  }
}
