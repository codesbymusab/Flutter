import 'package:flutter/material.dart';
import 'package:studdy_buddy/utils/themes/app_colors.dart';

class AnswerTile extends StatelessWidget {
  final String option;
  final String answer;
  final bool selected;
  final VoidCallback onTap;

  const AnswerTile({
    super.key,
    required this.answer,
    required this.option,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        borderRadius: BorderRadius.circular(12),
        color: selectedTileColor(context),
        child: ListTile(
          onTap: onTap,
          selected: selected,
          enableFeedback: true,

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(12),
          ),
          tileColor: unselectedTileColor(context),
          leading: Text(
            option,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          title: Text(
            answer,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
      ),
    );
  }
}
