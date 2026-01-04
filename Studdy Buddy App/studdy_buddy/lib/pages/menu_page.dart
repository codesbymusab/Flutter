import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart' show ZoomDrawer;
import 'package:provider/provider.dart';
import 'package:studdy_buddy/components/drawer_button.dart';
import 'package:studdy_buddy/services/auth_services.dart';
import 'package:studdy_buddy/utils/themes/app_colors.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 0,
          right: 0,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: IconButton(
                icon: Icon(Icons.arrow_back_ios, size: 30, color: Colors.white),
                onPressed: () {
                  ZoomDrawer.of(context)!.toggle();
                },
              ),
            ),
          ),
        ),
        FutureBuilder(
          future: context.read<AuthServices>().user,
          builder: (context, asyncSnapshot) {
            if (asyncSnapshot.hasData) {
              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Welcome, ${asyncSnapshot.data!.username}',
                          style: Theme.of(context).textTheme.headlineMedium!
                              .apply(color: Colors.white),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          backgroundColor: primaryColor(context),
                          radius: 40,
                          child: Text(
                            asyncSnapshot.data!.username[0].toUpperCase(),
                            style: Theme.of(context).textTheme.headlineLarge!
                                .apply(color: Colors.white),
                          ),
                        ),
                      ),
                      Spacer(),
                      MenuDrawerButton(
                        buttonLabel: 'Contact',
                        icon: 'assets/icons/contact.svg',
                        route: '',
                      ),
                      MenuDrawerButton(
                        buttonLabel: 'Email',
                        icon: 'assets/icons/email.svg',
                        route: '',
                      ),
                      MenuDrawerButton(
                        buttonLabel: 'Github',
                        icon: 'assets/icons/github.svg',
                        route: '',
                      ),

                      MenuDrawerButton(
                        buttonLabel: 'Website',
                        icon: 'assets/icons/web.svg',
                        route: '',
                      ),

                      Spacer(flex: 4),
                      MenuDrawerButton(
                        buttonLabel: 'Logout',
                        icon: 'assets/icons/logout.svg',
                        route: '',
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return Padding(padding: EdgeInsetsGeometry.all(0));
            }
          },
        ),
      ],
    );
  }
}
