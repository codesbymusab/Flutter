import 'package:flutter/material.dart';

class DialougeButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const DialougeButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(5),
        ),
      ),
      onPressed: onPressed,
      child: Text(text, style: Theme.of(context).textTheme.displayMedium),
    );
  }
}
