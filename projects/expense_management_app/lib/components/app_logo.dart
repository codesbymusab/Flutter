import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        margin: EdgeInsets.all(8),
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
          gradient: LinearGradient(colors: [Colors.white, Colors.orangeAccent]),
        ),
        padding: EdgeInsets.all(8),

        child: Image.asset('assets/images/logo.png', width: 200, height: 100),
      ),
    );
  }
}
