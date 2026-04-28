import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/provider/tasks_provider.dart';

class SelectListMenu extends StatelessWidget {
  final String label;
  final Color color;
  final double size;

  SelectListMenu({
    super.key,
    required this.label,
    required this.color,
    required this.size,
  });

  final TextEditingController menuController = TextEditingController(
    text: 'Default',
  );

  @override
  Widget build(BuildContext context) {
    final List<String> entries = context.watch<TasksProvider>().db.menuEntries;
    return DropdownMenu(
      controller: menuController,
      width: size,
      label: Text(label, style: Theme.of(context).textTheme.displayMedium),
      initialSelection: true,
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: color,
      ),

      menuStyle: MenuStyle(
        backgroundColor: WidgetStatePropertyAll(
          const Color.fromARGB(255, 245, 240, 220),
        ),
        fixedSize: WidgetStatePropertyAll(Size.fromWidth(size)),
        side: WidgetStatePropertyAll(
          BorderSide(color: const Color.fromARGB(105, 0, 0, 0)),
        ),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(5),
          ),
        ),
      ),
      textStyle: Theme.of(context).textTheme.titleSmall,

      trailingIcon: Icon(Icons.arrow_drop_down),

      dropdownMenuEntries: [
        for (int i = 0; i < entries.length; i++) ...{
          DropdownMenuEntry(value: entries[i], label: entries[i]),
        },
      ],
      onSelected: (value) {
        context.read<TasksProvider>().changelist(value as String);
      },
    );
  }
}
