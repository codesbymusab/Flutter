import 'package:flutter/material.dart';

class CartTileImage extends StatelessWidget {
  final String imageUrl;
  const CartTileImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            bottomLeft: Radius.circular(20),
          ),
        ),
        width: 150,
        height: 150,

        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(imageUrl, height: 150, fit: BoxFit.fitWidth),
        ),
      ),
    );
  }
}
