import 'package:flutter/material.dart';
import 'package:minitaskhub/auth/login_screen.dart';
import 'package:minitaskhub/dashboard/dashboard_screen.dart';
import 'package:minitaskhub/dashboard/task_provider.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main(List<String> args) async {

  //supabase setup
  await Supabase.initialize(
    anonKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imxoem9ncW5tcXJpZ213Z3hueWh3Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDUzMTY5NzcsImV4cCI6MjA2MDg5Mjk3N30.4u2A_qrX5t0olnTUXRsFpRSbiAtTQbIRtQteNPz7F30",
    url: "https://lhzogqnmqrigmwgxnyhw.supabase.co" 
  );
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => TaskProvider()),
    ],
    child: const MyApp(),
  ));
  
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
      home: const AuthGate(),
    );
  }
}

//listens to client's auth state and updates ui
class AuthGate extends StatelessWidget {
  const AuthGate({super.key});
  
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AuthState>(
      stream: Supabase.instance.client.auth.onAuthStateChange,
      builder: (context, snapshot) {
        final session = Supabase.instance.client.auth.currentSession;

        // While waiting for the stream to emit the first value
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // Session check
        if (session != null) {
          
          context.read<TaskProvider>().fetchTasks();
          return const DashboardScreen();
          
        } else {
          return const LoginScreen();
        }
      },
    );
  }
  
}


