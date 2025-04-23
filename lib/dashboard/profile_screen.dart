import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:minitaskhub/app/app_theme.dart';
import 'package:minitaskhub/auth/login_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/*
    Make a list of task
    These tasks are retrieved from the DB
    Option to add task
    Delete task
    Mark task as completed
*/
class ProfileScreen extends StatefulWidget{
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {  

  // Log out
  void logout() async {
  try {
    await Supabase.instance.client.auth.signOut();
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  } catch (e) {
    log('Logout failed: $e');
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Logout failed: $e')),
    );
  }
}
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ProfileAppBar(title: "Your Profile"),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Email display
            Center( child: Text(
                  "Swap with provider logic",
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
            ),    
            // Log out button    
            const SizedBox(height: 40),
            MyButton(
              label: "Log out",
              onPressed: () {
                logout();
              },
            ),
          ],
        ),
      ),
      
    );
  }

}
