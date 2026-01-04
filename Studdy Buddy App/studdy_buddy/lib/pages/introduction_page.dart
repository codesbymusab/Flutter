import 'package:flutter/material.dart';
import 'package:studdy_buddy/utils/themes/app_colors.dart';
import 'package:studdy_buddy/utils/themes/ui_parameters.dart';

class AppIntroDuctionPage extends StatelessWidget {
  const AppIntroDuctionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(gradient: mainGradinet(context)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 25,
          children: [
            Icon(Icons.star, color: Colors.amber, size: 65),
            const Text(
              'This is a study companion app.You can\n use it how you want,If you\n understand how it works.\n You would be able scale it.',
              textAlign: TextAlign.center,
            ),
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, 'SignupPage');
              },
              icon: Icon(Icons.arrow_forward, size: 35),
            ),
          ],
        ),
      ),
    );
  }
}
