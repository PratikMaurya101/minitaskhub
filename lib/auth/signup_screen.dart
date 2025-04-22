import 'package:flutter/material.dart';
import 'package:minitaskhub/app/app_theme.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

    //controllers for email and password
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirnmPasswordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirnmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SignInUpAppBar(title:"Sign Up"),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyTextField(
              label: "Email", 
              controller: emailController
            ),
            const SizedBox(height: 20),
            MyTextField(
              label: "Password",
              controller: passwordController,
              isPassword: true,
            ),
            const SizedBox(height: 30),
            MyTextField(
              label: "Confirm password",
              controller: confirnmPasswordController,
              isPassword: true,
            ),
            const SizedBox(height: 30),
            MyButton(
              label: "Sign Up",
              onPressed: () {
                //todo
              },
            ),
          ],
        ),
      ),
    );
  }
}