import 'package:flutter/material.dart';
import 'package:food_delivery_app/components/app__button.dart';
import 'package:food_delivery_app/components/form_text_field.dart';
import 'package:food_delivery_app/constants/colors.dart';
import 'package:food_delivery_app/services/user_services.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _loginKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    void onPressedLogin() async {
      if (_loginKey.currentState!.validate()) {
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

        if (result) {
          Navigator.pop(context);
          Navigator.pushNamed(context, 'homepage');
        } else {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: contrastColor,
              duration: Duration(seconds: 1),
              content: Text('Incorrect username or password!'),
            ),
          );
        }
      }
    }

    return Scaffold(
      backgroundColor: scaffoldColor,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _loginKey,
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                spacing: 20,
                children: [
                  Image.asset(
                    'assets/images/food_app.png',
                    width: 300,
                    height: 300,
                  ),

                  FormTextField(
                    hintText: 'Enter email',
                    isPassword: false,
                    controller: _emailController,
                    validator: (value) {
                      return value!.isEmpty ? 'Please enter email' : null;
                    },
                  ),

                  FormTextField(
                    hintText: 'Enter password',
                    isPassword: true,
                    controller: _passwordController,
                    validator: (value) {
                      return value!.isEmpty ? 'Please enter password' : null;
                    },
                  ),
                  AppButton(
                    color: contrastColor,
                    label: 'Login',
                    onPressed: onPressedLogin,
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
