import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studdy_buddy/database/app_database.dart';
import 'package:studdy_buddy/pages/introduction_page.dart';
import 'package:studdy_buddy/pages/login_page.dart';
import 'package:studdy_buddy/pages/main_page.dart';
import 'package:studdy_buddy/pages/signup_page.dart';
import 'package:studdy_buddy/pages/splashscreen_page.dart';
import 'package:studdy_buddy/services/auth_services.dart';
import 'package:studdy_buddy/services/study_services.dart';
import 'package:studdy_buddy/utils/themes/app_colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppDatabase.instance.database;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<StudyBuddyServices>(
          create: (context) => StudyBuddyServices(),
        ),
        ChangeNotifierProvider<AuthServices>(
          create: (context) => AuthServices(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: themeData(context),
        initialRoute: '/',
        routes: {
          '/': (context) => const AppSplashScreen(),
          'IntroductionPage': (context) => const AppIntroDuctionPage(),
          'LoginPage': (context) => const LoginPage(),
          'SignupPage': (context) => const SignUpPage(),
          'MainPage': (context) => const MainPage(),
        },
      ),
    );
  }
}
