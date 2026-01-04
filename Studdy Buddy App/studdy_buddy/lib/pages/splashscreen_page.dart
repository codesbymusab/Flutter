import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studdy_buddy/services/auth_services.dart';
import 'package:studdy_buddy/services/study_services.dart';
import 'package:studdy_buddy/utils/themes/app_colors.dart';
import 'package:studdy_buddy/utils/themes/app_dark_theme.dart';

class AppSplashScreen extends StatefulWidget {
  const AppSplashScreen({super.key});

  @override
  State<AppSplashScreen> createState() => _AppSplashScreenState();
}

class _AppSplashScreenState extends State<AppSplashScreen>
    with TickerProviderStateMixin {
  late final _animationController = AnimationController(
    vsync: this,
    duration: Duration(milliseconds: 600),
  )..repeat(reverse: true);
  late final _animation = Tween(begin: Offset(0, -0.2), end: Offset(0, 0.2))
      .animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
      );

  @override
  void initState() {
    super.initState();
    moveToIntroScreen();
  }

  void moveToIntroScreen() async {
    // await context.read<StudyBuddyServices>().initializeStudyMaterial();
    context.read<AuthServices>().signOutUser();

    Future.delayed(Duration(milliseconds: 4400), () async {
      if (!mounted) return;

      if (await context.read<AuthServices>().isUserLoggedIn()) {
        if (!mounted) return;
        Navigator.pushReplacementNamed(context, 'MainPage');
      } else {
        if (!mounted) return;
        Navigator.pushReplacementNamed(context, 'IntroductionPage');
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: AlignmentDirectional.center,
        decoration: BoxDecoration(gradient: mainGradinet(context)),
        child: SlideTransition(
          position: _animation,
          child: Image.asset(
            'assets/images/app_splash_logo.png',
            height: 200,
            width: 200,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
