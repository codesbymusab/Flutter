import 'package:expense_management_app/components/app_logo.dart';
import 'package:expense_management_app/components/form_text_field.dart';
import 'package:expense_management_app/constants/colors.dart';
import 'package:expense_management_app/models/user_model.dart';
import 'package:expense_management_app/services/auth_services.dart';
import 'package:expense_management_app/services/validators.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  bool obscureCharacter = true;
  final _loginKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final userService = Provider.of<UserAuth>(context);

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
                  Text(
                    'Create an Account',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  FormTextField(
                    hintText: 'Username',
                    isPassword: false,
                    controller: _nameController,
                    validator: emailValidator,
                  ),
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

                        final User user = User(
                          id: Uuid().v1(),
                          email: _emailController.text.trim(),
                          password: _passwordController.text.trim(),
                          userName: _nameController.text.trim(),
                        );
                        final res = await userService.registerUser(user);

                        Navigator.pop(context);

                        if (res) {
                          Navigator.pushReplacementNamed(context, 'login');
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
                    child: Text('Sign Up'),
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
