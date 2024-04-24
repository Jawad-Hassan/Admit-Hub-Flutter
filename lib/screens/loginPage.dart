import '../Controllers/auth_controller.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../customWidgets/CustomAppBar.dart';
import '../customWidgets/roundedtextfields.dart';
import 'ForgotPassword.dart';

class LoginPage extends StatefulWidget {
  final Function() onClickedSignUp;

  const LoginPage({
    Key? key,
    required this.onClickedSignUp,
  }) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthController authController = AuthController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      appBar: CustomAppBar(
        title: 'ADMIT HUB',
        actions: [],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
              key: authController.formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 40),
                  RoundedTextField(labelText: 'Email', controller: authController.emailController),
                  SizedBox(height: 18),
                  RoundedTextField(labelText: 'Password', controller: authController. passwordController),
                  SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: () =>
                        authController.signIn(context),
                    icon: Icon(Icons.lock_open, size: 20),
                    label: Text(
                      "Sign In",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  SizedBox(height: 5),
                  RichText(
                    text: TextSpan(
                      style: TextStyle(color: Colors.blue.shade900, fontSize: 15),
                      text: 'Forgot Password?',
                      children: [
                        TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => ForgotPassword(),
                                ),
                              );
                            },
                          text: ' Reset',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 5),
                  RichText(
                    text: TextSpan(
                      style: TextStyle(color: Colors.blue.shade900, fontSize: 15),
                      text: 'Create Account.',
                      children: [
                        TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = widget.onClickedSignUp,
                          text: ' Sign Up',
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
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
