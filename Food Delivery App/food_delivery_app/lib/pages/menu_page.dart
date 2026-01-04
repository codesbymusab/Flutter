import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:food_delivery_app/components/help_dialouge.dart';
import 'package:food_delivery_app/constants/colors.dart';
import 'package:food_delivery_app/constants/menu_options.dart';
import 'package:food_delivery_app/models/menu_option.dart';
import 'package:food_delivery_app/services/user_services.dart';
import 'package:provider/provider.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<MenuOption> allOptions = MenuOptions.allOptions;
    return Scaffold(
      backgroundColor: scaffoldColor,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () {
                ZoomDrawer.of(context)!.toggle();
              },
              icon: Icon(Icons.close_rounded, color: Colors.black),
            ),
          ),
          FutureBuilder(
            future: context.read<AuthServices>().user,
            builder: (context, asyncSnapshot) {
              if (asyncSnapshot.hasData) {
                return Column(
                  spacing: 8,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black87,
                      child: Text(
                        asyncSnapshot.data!.username[0].toUpperCase(),
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    Text(
                      'Hello,\n${asyncSnapshot.data!.username}',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ],
                );
              } else {
                return Padding(padding: EdgeInsetsGeometry.all(0));
              }
            },
          ),
          Expanded(
            child: ListView.builder(
              itemCount: allOptions.length,
              itemBuilder: (context, index) => Material(
                color: scaffoldColor,
                child: ListTile(
                  splashColor: Colors.amber.shade600,
                  leading: Icon(allOptions[index].icon, color: Colors.black),
                  titleTextStyle: TextStyle(fontSize: 20, color: Colors.black),
                  title: Text(allOptions[index].title),
                  onTap: () {
                    if (allOptions[index].title == 'Home') {
                      ZoomDrawer.of(context)!.toggle();
                    } else if (allOptions[index].title == 'Help') {
                      showDialog(
                        context: context,
                        builder: (context) => HelpDialouge(),
                      );
                    } else if (allOptions[index].title == 'Logout') {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            backgroundColor: Colors.amberAccent,
                            title: Text(
                              'Sign Out',
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                            content: Text('Are you sure,You want to sign out?'),
                            actions: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'No',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  await context.read<AuthServices>().signOut();
                                  Navigator.pushReplacementNamed(
                                    context,
                                    'login',
                                  );
                                },
                                child: Text(
                                  'Yes',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                      Navigator.pushNamed(context, allOptions[index].route);
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
