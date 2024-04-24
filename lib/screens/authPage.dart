import 'package:flutter/material.dart';
import 'SignupPage.dart';
import 'loginPage.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;

  @override
  Widget build(BuildContext context) =>
      isLogin ? LoginPage(onClickedSignUp: toggle)
          : SignupPage(onClickedSignIn: toggle);

  void toggle() => setState(() => isLogin = !isLogin );
}
