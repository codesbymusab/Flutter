import 'package:flutter/material.dart';
import 'package:studdy_buddy/utils/themes/app_dark_theme.dart';
import 'package:studdy_buddy/utils/themes/app_light_theme.dart';

class FormElevatedButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  const FormElevatedButton({
    super.key,
    required this.onPressed,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColorLight,
        overlayColor: primaryColorDark,
      ),
      onPressed: onPressed,
      child: Text(
        label,
        style: Theme.of(
          context,
        ).textTheme.labelMedium!.apply(color: Colors.white),
      ),
    );
  }
}
