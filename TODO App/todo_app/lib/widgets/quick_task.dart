import 'package:flutter/material.dart';

class QuickTaskAdder extends StatefulWidget {
  final VoidCallback onPressed;
  final TextEditingController quickTaskController;
  const QuickTaskAdder({
    super.key,
    required this.onPressed,
    required this.quickTaskController,
  });

  @override
  State<QuickTaskAdder> createState() => _QuickTaskAdderState();
}

class _QuickTaskAdderState extends State<QuickTaskAdder> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextField(
        controller: widget.quickTaskController,
        showCursor: true,
        autofocus: false,
        cursorColor: Colors.black,
        decoration: InputDecoration(
          filled: true,
          fillColor: Theme.of(context).colorScheme.primary,
          hintText: 'Enter Quick Task Here',
          focusedBorder: UnderlineInputBorder(),
          suffixIcon: IconButton(
            onPressed: widget.onPressed,
            icon: Icon(Icons.done, color: const Color.fromARGB(215, 0, 0, 0)),
          ),
        ),
      ),
    );
  }
}
