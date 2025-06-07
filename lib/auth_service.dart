import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient _client = Supabase.instance.client;

  Future<bool> loginWithPhoneAndPassword(String phone, String password) async {
    try {
      final response = await _client
          .from('users')
          .select()
          .eq('phone', phone)
          .eq('password', password) // لاحقاً استبدلها بهاش للتشفير
          .maybeSingle();

      return response != null;
    } catch (e) {
      print('Login error: $e');
      return false;
    }
  }
}
