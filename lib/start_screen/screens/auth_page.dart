import 'package:flutter/material.dart';
import 'package:pfs/start_screen/screens/sign_in.dart';
import 'package:pfs/start_screen/screens/sign_up.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);
  @override
  AuthPageState createState() => AuthPageState();
}

class AuthPageState extends State<AuthPage> {
  bool isLogin = true;

  void toggle() => setState(() => isLogin = !isLogin);

  @override
  Widget build(BuildContext context) {
    return isLogin
        ? SignInScreen(onClickedSignUp: toggle)
        : SignUpScreen(onClickedSignIn: toggle);
  }
}
