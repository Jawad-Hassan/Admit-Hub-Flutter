import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../customWidgets/roundedtextfields.dart';
import 'package:admit_hub/customWidgets/CustomAppBar.dart';
import '../Utils/utils.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      appBar: CustomAppBar
        (title: 'Forgot Password', actions: []),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RoundedTextField(labelText: 'Email', controller:  emailController,),
              SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () => resetPass(context),
                icon: Icon(Icons.lock_open, size: 20),
                label: Text(
                  "Reset",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> resetPass(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) => Center(
        child: CircularProgressIndicator(),
      ),
    );

    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());
      Utils.showSnackBar(context as String?, 'Password Reset Email Sent');
      Navigator.of(context).popUntil((route) => route.isFirst);
    } on FirebaseAuthException catch (e) {
      print(e);
      Utils.showSnackBar(context as String?, e.message);
      Navigator.of(context).pop();
    }
  }
}
