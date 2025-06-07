import 'package:flutter/material.dart';
import 'auth_service.dart'; // تأكد أن المسار صحيح

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _loading = false;
  String? _error;

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _loading = true;
        _error = null;
      });

      final success = await AuthService().loginWithPhoneAndPassword(
        _phoneController.text.trim(),
        _passwordController.text.trim(),
      );

      setState(() {
        _loading = false;
      });

      if (success) {
        // ✅ نجاح تسجيل الدخول
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('تم تسجيل الدخول بنجاح')));

        // TODO: الانتقال إلى الصفحة التالية
      } else {
        setState(() {
          _error = 'رقم الهاتف أو كلمة المرور غير صحيحة';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (_error != null)
                  Text(_error!, style: const TextStyle(color: Colors.red)),
                TextFormField(
                  controller: _phoneController,
                  decoration: const InputDecoration(labelText: 'رقم الهاتف'),
                  validator: (value) =>
                      value == null || value.isEmpty ? 'أدخل رقم الهاتف' : null,
                ),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(labelText: 'كلمة المرور'),
                  obscureText: true,
                  validator: (value) => value == null || value.isEmpty
                      ? 'أدخل كلمة المرور'
                      : null,
                ),
                const SizedBox(height: 20),
                _loading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: _login,
                        child: const Text('تسجيل الدخول'),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
