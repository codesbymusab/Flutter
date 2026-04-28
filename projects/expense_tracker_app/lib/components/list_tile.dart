import 'package:expense_tracker_app/model/expenses.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class MyListTile extends StatefulWidget {
  final Expense currentExpense;
  final void Function(BuildContext)? onPressedEdit;
  final void Function(BuildContext)? onPressedDelete;
  const MyListTile(
      {Key? key,
      required this.currentExpense,
      required this.onPressedEdit,
      required this.onPressedDelete})
      : super(key: key);

  @override
  State<MyListTile> createState() => _ListTileState();
}

class _ListTileState extends State<MyListTile> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 25),
        child: Slidable(
          enabled: true,
          endActionPane: ActionPane(motion: StretchMotion(), children: [
            SlidableAction(
              onPressed: widget.onPressedEdit,
              icon: Icons.settings,
              backgroundColor: Colors.black54,
              borderRadius: BorderRadius.circular(4),
            ),
            SlidableAction(
              padding: EdgeInsets.all(25),
              onPressed: widget.onPressedDelete,
              icon: Icons.delete,
              backgroundColor: Colors.red,
              borderRadius: BorderRadius.circular(4),
            )
          ]),
          child: ListTile(
            title: Text(widget.currentExpense.name),
            trailing: Text('PKR ${widget.currentExpense.amount.toString()}'),
            tileColor: Colors.grey.shade200,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(4)),
            contentPadding: EdgeInsets.all(8),
          ),
        ),
      ),
    );
  }
}
