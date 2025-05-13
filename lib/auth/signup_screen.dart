import 'package:flutter/material.dart';
import 'package:minitaskhub/app/app_theme.dart';
import 'package:minitaskhub/auth/auth_service.dart';
import 'package:minitaskhub/dashboard/dashboard_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  final authService = AuthService();

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

  //Signup function
  void signup() async {
    final email = emailController.text;
    final password = passwordController.text;

    try{
      await authService.singUpWithEmailPassword(email, password);
        if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const DashboardScreen()),
        );
      }
    }
    catch(e){
      if(mounted){
        ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error: $e")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: SignInUpAppBar(title:"Sign Up"),
      body: SingleChildScrollView(
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
                signup();
              },
            ),
          ],
        ),
      ),      
    );
  }
}