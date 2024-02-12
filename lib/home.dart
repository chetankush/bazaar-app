import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import 'addToCart.dart';

class Home extends StatefulWidget {
  const Home({Key? key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> productImages = [
    "https://m.media-amazon.com/images/I/615MuR0PG-L._SX679_.jpg",
    "https://m.media-amazon.com/images/I/8182o6d5QAL._SX679_.jpg",
    "https://m.media-amazon.com/images/I/71XSuZd2ylL._SX679_.jpg",
    // Add more image URLs as needed
  ];

  List<Map<String, dynamic>> products = [
    {
      'name': 'Product 1',
      'description': 'Description 1',
      'price': 19.99,
      'image': 'https://m.media-amazon.com/images/I/71XLyhwh19L._SL1300_.jpg',
    },
    {
      'name': 'Product 2',
      'description': 'Description 2',
      'price': 19.99,
      'image': 'https://m.media-amazon.com/images/I/51g2gkBDhkL.jpg',
    },
    {
      'name': 'Product 3',
      'description': 'Description 3',
      'price': 22.99,
      'image': 'https://m.media-amazon.com/images/I/8182o6d5QAL._SX679_.jpg',
    },
    // Add more products as needed
  ];

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
              Navigator.push(context, MaterialPageRoute(builder: (context)=> CartPage(cartItems: [
                {
                  'name': 'Product 1',
                  'description': 'Description 1',
                  'price': 19.99,
                  'image': 'https://m.media-amazon.com/images/I/8182o6d5QAL._SX679_.jpg',
                },
                {
                  'name': 'Product 2',
                  'description': 'Description 2',
                  'price': 19.99,
                  'image': 'https://m.media-amazon.com/images/I/71XLyhwh19L._SL1300_.jpg',
                },
                {
                  'name': 'Product 3',
                  'description': 'Description 2',
                  'price': 22.99,
                  'image': 'https://m.media-amazon.com/images/I/8182o6d5QAL._SX679_.jpg',
                },
                // Add more products as needed
              ],)));

            },
          ),
        ],
      ),
      body: ListView(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              height: 200.0,
              enlargeCenterPage: true,
              autoPlay: true,
              aspectRatio: 16 / 9,
            ),
            items: productImages.map((image) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(8.0),
                      image: DecorationImage(
                        image: NetworkImage(image),
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
                                      // You can add your logic for adding the product to the cart
                                      print('Added to Cart');
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
      ),
    );
  }
}


