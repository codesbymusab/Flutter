import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/providers/cart_provider.dart';

class ProductDetailPage extends StatefulWidget {
  final Map<String, dynamic> product;

  const ProductDetailPage({super.key, required this.product});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int selectedSize = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.black87),
        ),
        title: const Text('Details'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          spacing: 20,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              widget.product['title'],
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            Spacer(),
            ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(15),
              child: Container(
                color: Colors.white,
                height: 300,
                child: Image.asset(widget.product['imageUrl']),
              ),
            ),
            Spacer(),
            Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(249, 185, 222, 251),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: EdgeInsetsGeometry.symmetric(
                  vertical: 15,
                  horizontal: 8,
                ),
                child: Column(
                  spacing: 5,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        'PKR ${widget.product['price'].toString()}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,

                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.product['sizes'].length,
                        itemBuilder: (context, index) {
                          final size = widget.product['sizes'][index];
                          return Padding(
                            padding: const EdgeInsets.all(3),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedSize = widget.product['sizes'][index];
                                });
                              },
                              child: (Chip(
                                backgroundColor: selectedSize == size
                                    ? Theme.of(context).colorScheme.primary
                                    : Color.fromRGBO(246, 244, 242, 1),

                                label: Text(
                                  size.toString(),
                                  style: TextStyle(fontSize: 10),
                                ),
                                labelStyle: const TextStyle(fontSize: 16),
                                side: const BorderSide(
                                  color: Color.fromRGBO(141, 140, 140, 0.635),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    5,
                                  ),
                                ),
                              )),
                            ),
                          );
                        },
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          if (selectedSize != 0) {
                            Map<String, dynamic> product = {
                              'id': widget.product['id'],
                              'title': widget.product['title'],
                              'price': widget.product['price'],
                              'imageUrl': widget.product['imageUrl'],
                              'company': widget.product['company'],
                              'selectedSize': selectedSize,
                            };
                            context.read<CartProvider>().addProduct(product);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                padding: EdgeInsets.all(12),
                                content: Text(
                                  'Item added to cart successfully!',
                                  style: TextStyle(color: Colors.amberAccent),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadiusGeometry.vertical(
                                    top: Radius.circular(10),
                                  ),
                                ),
                                duration: Duration(seconds: 1),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                padding: EdgeInsets.all(12),
                                content: Text(
                                  'Please select size!',
                                  style: TextStyle(color: Colors.amberAccent),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadiusGeometry.vertical(
                                    top: Radius.circular(10),
                                  ),
                                ),
                                duration: Duration(seconds: 1),
                              ),
                            );
                          }
                        });
                      },
                      style: ButtonStyle(
                        minimumSize: WidgetStatePropertyAll(
                          Size.fromHeight(50),
                        ),
                        backgroundColor: WidgetStatePropertyAll(
                          Theme.of(context).colorScheme.primary,
                        ),
                        shape: WidgetStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadiusGeometry.circular(30),
                          ),
                        ),
                        foregroundColor: WidgetStatePropertyAll(Colors.black),
                      ),
                      child: Row(
                        spacing: 5,
                        mainAxisAlignment: MainAxisAlignment.center,

                        children: [
                          Icon(Icons.shopping_cart_outlined),
                          Text('Add to Cart'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
