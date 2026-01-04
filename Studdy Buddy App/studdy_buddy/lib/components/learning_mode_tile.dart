import 'package:flutter/material.dart';
import 'package:studdy_buddy/models/topic_model.dart';
import 'package:studdy_buddy/utils/themes/app_colors.dart';
import 'package:studdy_buddy/utils/themes/app_light_theme.dart';

class LearningModeTile extends StatelessWidget {
  final String mode;
  final VoidCallback onPressed;
  final String icon;
  const LearningModeTile({
    super.key,
    required this.icon,
    required this.mode,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8.0),
      child: Material(
        color: Colors.transparent,
        child: ListTile(
          minTileHeight: 60,
          dense: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 20),
          onTap: onPressed,
          tileColor: primaryContainerColor(context),
          splashColor: primaryLightColor(context),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(20),
          ),
          title: Text(mode, style: Theme.of(context).textTheme.bodySmall),
          leading: Image.asset(
            icon,
            width: 50,
            height: double.infinity,
            fit: BoxFit.fitWidth,
          ),
        ),
      ),
    );
  }
}
