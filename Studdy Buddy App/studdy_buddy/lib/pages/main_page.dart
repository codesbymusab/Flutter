import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:studdy_buddy/pages/home_page.dart';
import 'package:studdy_buddy/pages/menu_page.dart';
import 'package:studdy_buddy/utils/themes/app_colors.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: mainGradinet(context)),
        child: ZoomDrawer(
          style: DrawerStyle.defaultStyle,
          mainScreenTapClose: true,
          menuScreen: MenuPage(),
          mainScreen: HomePage(),
          angle: 0.0,
          showShadow: true,
          borderRadius: 50,
          menuBackgroundColor: Colors.white10,

          menuScreenWidth: double.maxFinite,
        ),
      ),
    );
  }
}
