import 'package:expense_management_app/components/app__button.dart';
import 'package:expense_management_app/constants/colors.dart';
import 'package:expense_management_app/models/user_model.dart';
import 'package:expense_management_app/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  final User user;
  const AppDrawer({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    void signOut() async {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder:
            (_) => Center(
              child: SizedBox(
                height: 40,
                width: 40,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ),
      );
      if (await context.read<UserAuth>().logoutUser()) {
        Navigator.pop(context);

        Navigator.pushReplacementNamed(context, 'login');
      }
    }

    ;

    return Drawer(
      backgroundColor: scaffoldColor,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 20,
          children: [
            CircleAvatar(
              backgroundColor: Colors.orangeAccent,
              radius: 40,
              child: Text(
                user.userName[0].toUpperCase(),
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            Text(user.userName, style: Theme.of(context).textTheme.titleLarge),
            Text(user.email, style: Theme.of(context).textTheme.titleLarge),
            Text(
              'Joined At: ${DateFormat(DateFormat.YEAR_MONTH_DAY).format(user.joinedAt)}',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            AppButton(
              color: Colors.orange,
              label: 'Sign Out',
              onPressed: signOut,
            ),
          ],
        ),
      ),
    );
  }
}
