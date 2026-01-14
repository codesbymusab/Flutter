import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String title;
  final int price;
  final String img;
  final int id;

  const ProductCard({
    super.key,
    required this.title,
    required this.price,
    required this.img,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 12,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              'PKR ${price.toString()}',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            Center(child: Image(image: AssetImage(img))),
          ],
        ),
      ),
    );
  }
}
