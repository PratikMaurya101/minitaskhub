import 'package:flutter/material.dart';
import 'package:minitaskhub/auth/login_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main(List<String> args) async {

  //supabase setup
  await Supabase.initialize(
    anonKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imxoem9ncW5tcXJpZ213Z3hueWh3Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDUzMTY5NzcsImV4cCI6MjA2MDg5Mjk3N30.4u2A_qrX5t0olnTUXRsFpRSbiAtTQbIRtQteNPz7F30",
    url: "https://lhzogqnmqrigmwgxnyhw.supabase.co" 
  );
  runApp(MyApp());
  
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        appBarTheme: AppBarTheme(
          backgroundColor: Color.fromARGB(255, 21, 28, 32),
          foregroundColor: Colors.amber
        ),
      ),
      home: const LoginScreen(),
    );
  }
}


