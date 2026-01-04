import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:provider/provider.dart';
import 'package:studdy_buddy/components/form_elevated_button.dart';
import 'package:studdy_buddy/components/form_text_field.dart';
import 'package:studdy_buddy/pages/home_page.dart';
import 'package:studdy_buddy/pages/menu_page.dart';
import 'package:studdy_buddy/services/auth_services.dart';
import 'package:studdy_buddy/utils/themes/app_colors.dart';
import 'package:studdy_buddy/utils/themes/app_dark_theme.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _loginFormKey = GlobalKey();
  void onPressedLogin() async {
    if (_loginFormKey.currentState!.validate()) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return Center(
            child: SizedBox(
              height: 50,
              child: CircularProgressIndicator(color: Colors.white),
            ),
          );
        },
      );
      final authServices = context.read<AuthServices>();

      final result = await authServices.loginUser(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );

      if (result != null) {
        if (!mounted) return;
        Navigator.pop(context);
        Navigator.pushNamed(context, 'MainPage');
      } else {
        if (!mounted) return;
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: primaryColor(context),
            duration: Duration(seconds: 1),
            content: Text(
              'Incorrect username or password!',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(gradient: mainGradinet(context)),
        child: Form(
          key: _loginFormKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('LOGIN', style: Theme.of(context).textTheme.headlineLarge),
                Container(
                  margin: EdgeInsets.all(25),
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 247, 228, 250),
                    borderRadius: BorderRadius.circular(20),
                  ),

                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      spacing: 20,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FormTextField(
                          icon: Icons.mail,
                          hintText: 'email',
                          isPassword: false,
                          controller: _emailController,
                          validator: (text) {
                            return null;
                          },
                        ),
                        FormTextField(
                          icon: Icons.password,
                          hintText: 'password',
                          isPassword: true,
                          controller: _passwordController,
                          validator: (text) {
                            return null;
                          },
                        ),
                        SizedBox(
                          width: 300,
                          child: FormElevatedButton(
                            onPressed: onPressedLogin,
                            label: 'Sign In',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Text(
                  'Don\'t have an account?',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: 150,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: const Color.fromARGB(255, 247, 228, 250),
                      overlayColor: primaryLightColorDark,
                    ),
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, 'SignupPage');
                    },
                    child: Text(
                      'Sign Up',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
