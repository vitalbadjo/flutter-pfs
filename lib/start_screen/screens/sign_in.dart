/// start screen
/// check auth
/// if ok - go to -> check if user pin code configured ok->route to pin code else-> route to restricted
/// else - prompt auth
/// if not registered route to sign up
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../main.dart';
import 'forgot_password_page.dart';
import 'utils.dart';

class SignInScreen extends StatefulWidget {
  final VoidCallback onClickedSignUp;
  const SignInScreen({Key? key, required this.onClickedSignUp})
      : super(key: key);

  @override
  SignInScreenState createState() => SignInScreenState();
}

class SignInScreenState extends State<SignInScreen> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future signIn() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar(e.message);
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            const Text(
              'Authentication',
              style: TextStyle(
                fontSize: 40,
              ),
            ),
            const SizedBox(height: 40),
            TextFormField(
              controller: emailController,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(labelText: "Enter email"),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (email) =>
                  email != null && !EmailValidator.validate(email)
                      ? 'Enter a valid email'
                      : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: passwordController,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(labelText: "Enter password"),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (pass) => pass != null && pass.length < 6
                  ? 'Enter min. 6 characters'
                  : null,
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(54)),
              icon: const Icon(Icons.lock_open),
              label: const Text("Sign In", style: TextStyle(fontSize: 24)),
              onPressed: signIn,
            ),
            const SizedBox(height: 24),
            GestureDetector(
              child: const Text(
                'Forgot password',
                style: TextStyle(
                    decoration: TextDecoration.underline, fontSize: 16),
              ),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const ForgotPasswordPage())),
            ),
            const SizedBox(height: 16),
            RichText(
                text: TextSpan(
                    style: const TextStyle(fontSize: 16),
                    text: 'No account?  ',
                    children: [
                  TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = widget.onClickedSignUp,
                      text: 'Sign Up',
                      style:
                          const TextStyle(decoration: TextDecoration.underline))
                ])),
          ],
        ),
      ),
    );
  }
}
