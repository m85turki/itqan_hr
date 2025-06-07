import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // رقم الهاتف
            TextField(
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: 'رقم الهاتف',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            // كلمة المرور
            TextField(
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'كلمة المرور',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            // زر تسجيل الدخول
            ElevatedButton(
              onPressed: () {
                // هنا نضيف التحقق لاحقاً
              },
              child: const Text('تسجيل الدخول'),
            ),

            const SizedBox(height: 10),

            // رابط إنشاء حساب
            TextButton(
              onPressed: () {
                // ننتقل لشاشة التسجيل لاحقاً
              },
              child: const Text('ليس لديك حساب؟ سجل الآن'),
            ),
          ],
        ),
      ),
    );
  }
}
