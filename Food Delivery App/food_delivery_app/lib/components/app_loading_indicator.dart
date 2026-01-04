import 'package:flutter/material.dart';

class AppLoadingIndicator extends StatelessWidget {
  final double size;
  const AppLoadingIndicator({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: size,
        width: size,
        child: Center(
          child: CircularProgressIndicator(
            backgroundColor: Colors.white,
            color: Colors.black54,
            strokeWidth: 4,
          ),
        ),
      ),
    );
  }
}
