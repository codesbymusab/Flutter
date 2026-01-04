import 'package:flutter/material.dart';
import 'package:studdy_buddy/utils/themes/app_colors.dart';
import 'package:studdy_buddy/utils/themes/app_dark_theme.dart';
import 'package:studdy_buddy/utils/themes/app_light_theme.dart';

class AppElevatedButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final TextStyle? labelStyle;
  const AppElevatedButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.backgroundColor,
    this.labelStyle,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? secondaryColor(context),
        overlayColor: primaryColor(context),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(12),
        ),
      ),
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Text(
          label,
          style:
              labelStyle ??
              Theme.of(context).textTheme.labelMedium!.apply(
                color: Colors.white,
                fontSizeDelta: 5,
              ),
        ),
      ),
    );
  }
}
