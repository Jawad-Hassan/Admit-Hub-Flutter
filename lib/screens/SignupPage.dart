import '../Controllers/auth_controller.dart';
import 'package:admit_hub/customWidgets/CustomAppBar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../customWidgets/roundedtextfields.dart';


class SignupPage extends StatefulWidget {
  final Function() onClickedSignIn;
  final AuthController authController = AuthController();

  SignupPage({Key? key, required this.onClickedSignIn,})
      : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final AuthController authController = AuthController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      appBar: CustomAppBar(
        title: 'Create New Account',
        actions: [],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: authController.formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 40),
              RoundedTextField(labelText: 'Email', controller:  authController.emailController,),
              SizedBox(height: 18),
              RoundedTextField(labelText: 'Password', controller: authController.passwordController,),
              SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () => authController.signUp(context),
                icon: Icon(Icons.arrow_forward, size: 20),
                label: Text(
                  "Sign Up",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              SizedBox(height: 5),
              RichText(
                text: TextSpan(
                  style: TextStyle(color: Colors.blue.shade900, fontSize: 15),
                  text: 'Already Have Account?',
                  children: [
                    TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = widget.onClickedSignIn,
                      text: ' Log In',
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
    );
  }
}
