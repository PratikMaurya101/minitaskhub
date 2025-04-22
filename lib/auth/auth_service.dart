
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient _supabase = Supabase.instance.client;

  //signin
  Future<AuthResponse> signInWithEmailPassword(
    String email, String password
    ) async {
      return await _supabase.auth.signInWithPassword(email: email,password: password);
    } 

  //signup
  Future<AuthResponse> singUpWithEmailPassword(
    String email, String password
  ) async {
    return await _supabase.auth.signUp(email: email, password: password);
  }
  //signout
  Future<void> singOut() async {
    await _supabase.auth.signOut();
  }

  //get current session
  String? getCurrentUser() {
      final Session? session = _supabase.auth.currentSession;
      final user = session?.user;
      return user?.email;
  }

} 