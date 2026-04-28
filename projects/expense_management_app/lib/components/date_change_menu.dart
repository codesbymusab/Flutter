import 'package:expense_management_app/services/auth_services.dart';
import 'package:expense_management_app/services/fin_services.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DateChangeMenu extends StatelessWidget {
  const DateChangeMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final outlineInputBorder = OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
      borderRadius: BorderRadius.circular(10),
    );

    TextEditingController dateController = TextEditingController(
      text: DateFormat(DateFormat.YEAR_ABBR_MONTH).format(DateTime.now()),
    );

    List<({int month, int year})> dates =
        context.read<UserAuth>().userJoinedPeriod();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DropdownMenu(
        controller: dateController,
        onSelected: (value) {
          context.read<FinAuth>().changedDate(value.month, value.year);
        },
        textStyle: Theme.of(context).textTheme.displaySmall,
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder: outlineInputBorder,
          focusedBorder: outlineInputBorder,
        ),

        dropdownMenuEntries: <DropdownMenuEntry>[
          for (var date in dates)
            DropdownMenuEntry(
              value: (date),
              label: DateFormat(
                DateFormat.YEAR_ABBR_MONTH,
              ).format(DateTime(date.year, date.month)),
            ),
        ],
      ),
    );
  }
}
