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
import 'utils.dart';

class SignUpScreen extends StatefulWidget {
  final VoidCallback onClickedSignIn;
  const SignUpScreen({Key? key, required this.onClickedSignIn})
      : super(key: key);

  @override
  SignUpScreenState createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignUpScreen> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmController = TextEditingController();

  Future signUp() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
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
              'Registration',
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
              obscureText: true,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (pass) => pass != null && pass.length < 6
                  ? 'Enter min. 6 characters'
                  : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: passwordConfirmController,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(labelText: "Confirm password"),
              obscureText: true,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (pass) => pass != passwordController.text
                  ? 'Passwords does not match'
                  : null,
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(54)),
              icon: const Icon(Icons.person),
              label: const Text("Sign Up", style: TextStyle(fontSize: 24)),
              onPressed: signUp,
            ),
            const SizedBox(height: 24),
            RichText(
                text: TextSpan(
                    style: const TextStyle(fontSize: 16),
                    text: 'Already have an account?  ',
                    children: [
                  TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = widget.onClickedSignIn,
                      text: 'Sign In',
                      style:
                          const TextStyle(decoration: TextDecoration.underline))
                ])),
          ],
        ),
      ),
    );
  }
}
