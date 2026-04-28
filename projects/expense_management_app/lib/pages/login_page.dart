import 'package:expense_management_app/components/app_logo.dart';
import 'package:expense_management_app/components/form_text_field.dart';
import 'package:expense_management_app/constants/colors.dart';
import 'package:expense_management_app/services/auth_services.dart';
import 'package:expense_management_app/services/validators.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool obscureCharacter = true;
  final _loginKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<UserAuth>(context);

    return Scaffold(
      backgroundColor: scaffoldColor,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _loginKey,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 20,
                children: [
                  AppLogo(),
                  FormTextField(
                    hintText: 'Email',
                    isPassword: false,
                    controller: _emailController,
                    validator: emailValidator,
                  ),

                  FormTextField(
                    hintText: 'Password',
                    isPassword: true,
                    controller: _passwordController,
                    validator: passwordValidator,
                  ),

                  ElevatedButton(
                    onPressed: () async {
                      if (_loginKey.currentState!.validate()) {
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder:
                              (_) => Center(
                                child: SizedBox(
                                  height: 40,
                                  width: 40,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                ),
                              ),
                        );

                        if (await authService.loginUser(
                          _emailController.text.trim(),
                          _passwordController.text.trim(),
                        )) {
                          Navigator.pop(context);

                          Navigator.pushReplacementNamed(context, 'home_page');
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Incorrect username or password',
                                style: TextStyle(color: Colors.red),
                              ),
                              duration: Duration(seconds: 2),
                            ),
                          );
                          Navigator.pop(context);
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepOrange,
                      foregroundColor: Colors.white,
                      fixedSize: Size.fromWidth(200),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(8),
                      ),
                    ),
                    child: Text('Login'),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t have an account?',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, 'signup');
                        },
                        child: Text(
                          'Sign Up',
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
