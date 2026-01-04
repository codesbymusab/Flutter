import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:food_delivery_app/pages/homepage.dart';
import 'package:food_delivery_app/pages/menu_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ZoomDrawer(
        mainScreenTapClose: true,
        menuScreen: MenuPage(),
        mainScreen: HomePage(),
        angle: -8.0,
      ),
    );
  }
}
