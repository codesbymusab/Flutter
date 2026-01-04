import 'package:expense_management_app/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    checkLoginSate();
  }

  void checkLoginSate() async {
    bool isUserLoggedIn = await context.read<UserAuth>().isUserLoggedIn();

    Future.delayed(Duration(seconds: 4), () {
      if (!isUserLoggedIn) {
        Navigator.pushReplacementNamed(context, 'login');
      } else {
        Navigator.pushReplacementNamed(context, 'home_page');
      }
    });
  }

  late final AnimationController _controller = AnimationController(
    duration: Duration(milliseconds: 1000),
    vsync: this,
  )..repeat(reverse: true);
  late final Animation<Offset> animation = Tween<Offset>(
    begin: Offset(0, 0),
    end: Offset(0, 2),
  ).animate(CurvedAnimation(parent: _controller, curve: Curves.elasticIn));
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SlideTransition(
            position: animation,
            child: Image.asset('assets/images/logo.png'),
          ),
        ],
      ),
    );
  }
}
