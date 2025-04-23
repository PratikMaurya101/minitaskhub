import 'package:flutter/material.dart';
import 'package:minitaskhub/app/app_theme.dart';
import 'package:minitaskhub/auth/auth_service.dart';
import 'package:minitaskhub/auth/signup_screen.dart';
import 'package:minitaskhub/dashboard/dashboard_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final authService = AuthService();

  //controllers for email and password
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  //login function
  void login() async {
    final email = emailController.text;
    final password = passwordController.text;

    try{
      await authService.signInWithEmailPassword(email, password);

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
      appBar: SignInUpAppBar(title:"Login"),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //email
            MyTextField(
              label: "Email", 
              controller: emailController
            ),
            const SizedBox(height: 20),
            //password
            MyTextField(
              label: "Password",
              controller: passwordController,
              isPassword: true,
            ),
            const SizedBox(height: 30),
            //login button
            MyButton(
              label: "Login",
              onPressed: () {
                login();
              },
            ),
            const SizedBox(height: 20),
            //redirect to signup
            GestureDetector(
              onTap: () => Navigator.push(
                context, 
                MaterialPageRoute(builder: (context) => const SignupScreen())
              ),
              child: Center(child: Text("Don't have an account? Click here to sign-up"))
            )
          ],
        ),
      ),
    );
  }

}
