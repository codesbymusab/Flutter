import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studdy_buddy/services/study_services.dart';
import 'package:studdy_buddy/utils/themes/app_colors.dart';

class NumberCard extends StatelessWidget {
  final Color color;
  final int number;
  final VoidCallback onPressed;

  const NumberCard({
    super.key,
    required this.number,
    required this.onPressed,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.all(8),
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: color,
          padding: EdgeInsets.all(12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(12),
          ),
        ),
        onPressed: onPressed,

        child: Text(
          number.toString(),
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}
