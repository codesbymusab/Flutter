import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studdy_buddy/components/form_elevated_button.dart';
import 'package:studdy_buddy/components/form_text_field.dart';
import 'package:studdy_buddy/models/user_model.dart';
import 'package:studdy_buddy/services/auth_services.dart';
import 'package:studdy_buddy/utils/themes/app_colors.dart';
import 'package:studdy_buddy/utils/themes/app_dark_theme.dart';
import 'package:uuid/uuid.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _signUpFormKey = GlobalKey();
  void onPressedSingUp() async {
    if (_signUpFormKey.currentState!.validate()) {
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

      final User user = User(
        id: Uuid().v1(),
        username: _usernameController.text,
        email: _emailController.text,
        password: _passwordController.text,
        joinedAt: DateTime.now(),
      );
      final authServices = context.read<AuthServices>();
      await authServices.registerUser(user);
      Navigator.pushReplacementNamed(context, 'LoginPage');
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
          key: _signUpFormKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'SIGN UP',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
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
                          icon: Icons.person,
                          hintText: 'username',
                          isPassword: false,
                          controller: _usernameController,
                          validator: (text) {
                            return null;
                          },
                        ),
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
                            onPressed: onPressedSingUp,
                            label: 'Sign Up',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Text(
                  'Already have an account?',
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
                    onPressed: onPressedSingUp,
                    child: Text(
                      'Sign In',
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
