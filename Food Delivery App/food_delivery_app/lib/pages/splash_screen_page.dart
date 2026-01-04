import 'package:flutter/material.dart';
import 'package:food_delivery_app/services/user_services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..repeat(reverse: true);
    _scale = Tween(
      begin: 0.8,
      end: 1.2,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    checkLoginState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void checkLoginState() async {
    final userAuth = AuthServices();
    final isLoggedIn = await userAuth.isUserLoggedIn();

    Future.delayed(Duration(seconds: 4), () {
      if (isLoggedIn) {
        Navigator.pushReplacementNamed(context, 'mainpage');
      } else {
        Navigator.pushReplacementNamed(context, 'login');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ScaleTransition(
          scale: _scale,
          child: ClipRRect(
            borderRadius: BorderRadiusGeometry.circular(10),
            child: Image.asset(
              'assets/images/food_app.png',
              height: 150,
              width: 150,
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }
}
