import 'package:flutter/material.dart';
import 'package:minitaskhub/auth/login_screen.dart';
import 'package:minitaskhub/dashboard/dashboard_screen.dart';
import 'package:minitaskhub/dashboard/task_provider.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
void main(List<String> args) async {

  // Load the .env file
  try {
    await dotenv.load(fileName: ".env");
    print("Loaded .env file successfully.");
  } catch (e) {
    print("Error loading .env file: $e");
  }

  //supabase setup
  await Supabase.initialize(  
    anonKey: dotenv.env['ANON_KEY']!,
    url: dotenv.env['URL']! 
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


