import 'package:expense_management_app/components/app__button.dart';
import 'package:expense_management_app/components/form_text_field.dart';
import 'package:flutter/material.dart';

class AddItem extends StatefulWidget {
  final TextEditingController categoryController;
  final TextEditingController descController;
  final TextEditingController amountController;
  final String label;
  final Color color;
  final VoidCallback onPressed;
  final List<String> categories;

  const AddItem({
    super.key,
    required this.categoryController,
    required this.descController,
    required this.amountController,
    required this.label,
    required this.color,
    required this.onPressed,
    required this.categories,
  });

  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  @override
  Widget build(BuildContext context) {
    final outlineInputBorder = OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
      borderRadius: BorderRadius.circular(10),
    );

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Column(
          mainAxisAlignment:
              MediaQuery.sizeOf(context).width > 450
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.start,
          spacing: 20,
          children: [
            SizedBox(height: 20),
            DropdownMenu(
              controller: widget.categoryController,
              width: 450,
              hintText: 'Category',
              textStyle: Theme.of(context).textTheme.displaySmall,
              inputDecorationTheme: InputDecorationTheme(
                enabledBorder: outlineInputBorder,
                focusedBorder: outlineInputBorder,

                hintStyle: Theme.of(context).textTheme.bodySmall,
              ),
              dropdownMenuEntries: <DropdownMenuEntry>[
                for (var entry in widget.categories)
                  DropdownMenuEntry(value: entry, label: entry),
              ],
            ),
            FormTextField(
              hintText: 'Description',
              isPassword: false,
              controller: widget.descController,
              validator: null,
            ),
            FormTextField(
              hintText: 'Amount',
              isPassword: false,
              controller: widget.amountController,
              validator: null,
            ),

            AppButton(
              color: widget.color,
              label: widget.label,
              onPressed: widget.onPressed,
            ),
          ],
        ),
      ),
    );
  }
}
