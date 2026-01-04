import 'package:flutter/material.dart';
import 'package:food_delivery_app/constants/colors.dart';
import 'package:food_delivery_app/db/app_database.dart';
import 'package:food_delivery_app/pages/all_items_page.dart';
import 'package:food_delivery_app/pages/cart_page.dart';
import 'package:food_delivery_app/pages/faqs_page.dart';
import 'package:food_delivery_app/pages/favourites_page.dart';
import 'package:food_delivery_app/pages/homepage.dart';
import 'package:food_delivery_app/pages/login_page.dart';
import 'package:food_delivery_app/pages/main_page.dart';
import 'package:food_delivery_app/pages/order_history_page.dart';
import 'package:food_delivery_app/pages/signup_page.dart';
import 'package:food_delivery_app/pages/splash_screen_page.dart';
import 'package:food_delivery_app/services/user_services.dart';
import 'package:food_delivery_app/services/item_services.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppDatabase.instance.database;

  ItemServices().initializeCategories();
  ItemServices().insertItems();
  AuthServices.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthServices>(
          create: (context) => AuthServices(),
        ),
        ChangeNotifierProvider<ItemServices>(
          create: (context) => ItemServices(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          tooltipTheme: TooltipThemeData(
            textStyle: TextStyle(color: Colors.amberAccent),
          ),
          textTheme: TextTheme(
            bodyLarge: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            bodyMedium: TextStyle(fontSize: 15),
            headlineMedium: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            headlineSmall: TextStyle(fontSize: 2, fontWeight: FontWeight.bold),
            bodySmall: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
            labelSmall: TextStyle(
              color: contrastColor,
              fontSize: 15,
              decoration: TextDecoration.underline,
              decorationColor: contrastColor,
              decorationThickness: 2,
            ),
            labelMedium: TextStyle(fontSize: 15),
            labelLarge: TextStyle(fontSize: 20),
            displayLarge: TextStyle(fontSize: 20),
            displayMedium: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            displaySmall: TextStyle(fontSize: 15, color: Colors.amberAccent),
          ),
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const SplashScreen(),
          'login': (context) => const LoginPage(),
          'mainpage': (context) => const MainPage(),
          'homepage': (context) => const HomePage(),
          'allitemspage': (context) => const AllProductsPage(),
          'signup': (context) => const SignUpPage(),
          'cartpage': (context) => const CartPage(),
          'favourites': (context) => const FavouritesPage(),
          'orderhistory': (context) => const OrderHistoryPage(),
          'faqs': (context) => const FaqsPage(),
        },
      ),
    );
  }
}
