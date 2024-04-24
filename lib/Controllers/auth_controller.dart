import 'package:flutter/widgets.dart';
import 'package:admit_hub/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Utils/utils.dart';

class AuthController {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> signUp(BuildContext context) async {

    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    showDialog(
      context: context,
      builder: (context) => Center(child: CircularProgressIndicator()),
    );

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      print("Error: $e");

      Utils.showSnackBar('Error! Try Again', e.message);

    }

    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  Future<void> signIn(BuildContext context) async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(child: CircularProgressIndicator()),
    );

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

    } on FirebaseAuthException catch (e) {
      print("Error signing in: $e");
      Utils.showSnackBar('Error! Try Again', e.message);
    }

    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }




}
