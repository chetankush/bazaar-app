import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'dart:convert';
import 'addToCart.dart';
import 'cartProvider.dart';

class Home extends StatelessWidget {
  Future<List<Map<String, dynamic>>> fetchData() async {
    final response = await http.get(Uri.parse('http://localhost:3001'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.cast<Map<String, dynamic>>();
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bazaar"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.add_business),
          onPressed: () {
            // Handle wishlist icon press
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartPage(cartItems: Provider.of<CartProvider>(context, listen: false).cartItems),
                ),
              );
            },
          ),


        ],
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data available'));
          } else {
            List<Map<String, dynamic>> products = snapshot.data!;
            return ListView(
              children: [
                CarouselSlider(
                  options: CarouselOptions(
                    height: 200.0,
                    enlargeCenterPage: true,
                    autoPlay: true,
                    aspectRatio: 16 / 9,
                  ),
                  items: products.map((product) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(8.0),
                            image: DecorationImage(
                              image: NetworkImage(product['image']),
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
                SizedBox(height: 16.0),
                Column(
                  children: products.map((product) {
                    return Container(
                      height: 300.0,
                      margin: EdgeInsets.only(
                        top: 20.0,
                        left: 10.0,
                        bottom: 10.0,
                        right: 10.0,
                      ),
                      child: Card(
                        child: Column(
                          children: [
                            Flexible(
                              flex: 2,
                              child: Container(
                                height: 200.0,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(product['image']),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  top: 20.0,
                                  left: 12.0,
                                  bottom: 10.0,
                                  right: 12.0,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 16.0),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                        ElevatedButton(
                                          onPressed: () {
                                            // Handle Add to Cart button press
                                            Provider.of<CartProvider>(context,
                                                listen: false)
                                                .addToCart(product);
                                            print('Product Added to Cart');

                                            ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(
                                                content: Text('Added to Cart'),
                                              ),
                                            );

                                          },
                                          child: Text("Add to Cart"),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
