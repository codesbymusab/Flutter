import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studdy_buddy/utils/themes/app_dark_theme.dart';

class FormTextField extends StatefulWidget {
  final IconData icon;
  final String hintText;
  final bool isPassword;
  final FormFieldValidator<String>? validator;
  final TextEditingController controller;
  const FormTextField({
    super.key,
    required this.icon,
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
    borderRadius: BorderRadius.circular(20),
    borderSide: BorderSide.none,
  );
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 450),
      child: TextFormField(
        controller: widget.controller,
        obscureText: obscureCharacter && widget.isPassword,
        style: Theme.of(context).textTheme.labelSmall,
        cursorColor: primaryColorDark,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          enabledBorder: outlineInputBorder,
          focusedBorder: outlineInputBorder,
          hintText: widget.hintText,
          hintStyle: TextStyle(color: Colors.black87),
          prefixIcon: Icon(widget.icon),
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
