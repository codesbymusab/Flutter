import 'package:flutter/material.dart';
import 'package:studdy_buddy/utils/themes/app_colors.dart';

class Background extends StatelessWidget {
  final Widget body;
  final double? height;
  const Background({super.key, this.height, required this.body});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.only(bottom: 20),
      child: Container(
        height: height ?? MediaQuery.sizeOf(context).height - 120,
        width: double.infinity,
        decoration: BoxDecoration(
          color: primaryContainerColor(context),
          borderRadius: BorderRadius.circular(20),
        ),
        clipBehavior: Clip.none,
        child: Padding(padding: const EdgeInsets.all(25.0), child: body),
      ),
    );
  }
}
