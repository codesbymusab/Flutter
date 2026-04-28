import 'package:flutter/material.dart';

class RoundElevatedButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback onPressed;
  const RoundElevatedButton({
    super.key,
    required this.icon,
    required this.onPressed,
  });

  @override
  State<RoundElevatedButton> createState() => _RoundElevatedButtonState();
}

class _RoundElevatedButtonState extends State<RoundElevatedButton> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: const EdgeInsets.only(left: 8, bottom: 8, top: 8),
        child: ElevatedButton(
          onPressed: widget.onPressed,

          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(20),
            shape: CircleBorder(),
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: const Color.fromARGB(215, 0, 0, 0),
          ),
          child: Icon(widget.icon, size: 25),
        ),
      ),
    );
  }
}
