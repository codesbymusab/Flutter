import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FormTextField extends StatefulWidget {
  final String hintText;
  final bool isPassword;
  final FormFieldValidator<String>? validator;
  final TextEditingController controller;
  const FormTextField({
    super.key,
    required this.hintText,
    required this.isPassword,
    required this.controller,
    required this.validator,
  });

  @override
  State<FormTextField> createState() => _FormTextFieldState();
}

class _FormTextFieldState extends State<FormTextField> {
  bool obscureCharacter = true;
  final outlineInputBorder = OutlineInputBorder(
    borderSide: BorderSide(width: 2, color: const Color.fromARGB(121, 0, 0, 0)),
    borderRadius: BorderRadius.circular(10),
  );
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 450),
      child: TextFormField(
        showCursor: false,
        controller: widget.controller,
        obscureText: obscureCharacter && widget.isPassword,
        style: Theme.of(context).textTheme.labelLarge,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          enabledBorder: outlineInputBorder,
          focusedBorder: outlineInputBorder,
          hintText: widget.hintText,
          hintStyle: Theme.of(context).textTheme.labelMedium,
          suffixIcon: widget.isPassword
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      obscureCharacter = !obscureCharacter;
                    });
                  },

                  icon: obscureCharacter
                      ? Icon(Icons.remove_red_eye, color: Colors.black54)
                      : Icon(
                          CupertinoIcons.eye_slash_fill,
                          color: Colors.black54,
                        ),
                )
              : null,
        ),
        validator: widget.validator,
      ),
    );
  }
}
