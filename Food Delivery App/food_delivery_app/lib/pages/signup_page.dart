import 'package:flutter/material.dart';
import 'package:food_delivery_app/components/app__button.dart';
import 'package:food_delivery_app/components/form_text_field.dart';
import 'package:food_delivery_app/constants/colors.dart';
import 'package:food_delivery_app/models/user_model.dart';
import 'package:food_delivery_app/services/user_services.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final _loginKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    void onPressedSignUp() async {
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

        User user = User(
          id: Uuid().v1(),
          username: _usernameController.text,
          email: _emailController.text,
          password: _passwordController.text,
          joinedAt: DateTime.now(),
        );
        final result = await context.read<AuthServices>().registerUser(user);

        if (result) {
          Navigator.pop(context);
          Navigator.pushNamed(context, 'login');
        } else {
          Navigator.pop(context);
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
                spacing: 10,
                children: [
                  Image.asset(
                    'assets/images/food_app.png',
                    width: 300,
                    height: 300,
                  ),

                  FormTextField(
                    hintText: 'Enter username',
                    isPassword: false,
                    controller: _usernameController,
                    validator: (value) {
                      return value!.isEmpty ? 'Please enter username' : null;
                    },
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
                      if (value!.isEmpty) {
                        return 'Please enter password';
                      } else if (value.length < 6) {
                        return 'Password must be six character long';
                      } else {
                        return null;
                      }
                    },
                  ),
                  AppButton(
                    color: contrastColor,
                    label: 'Sign Up',
                    onPressed: onPressedSignUp,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account?',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, 'login');
                        },
                        child: Text(
                          'Login',
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
