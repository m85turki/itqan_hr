import 'package:flutter/material.dart';

class VerifyEmailPage extends StatelessWidget {
  const VerifyEmailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Verify Email')),
      body: const Center(
        child: Text(
          'تم إرسال رابط التحقق إلى بريدك الإلكتروني. يرجى التحقق من البريد ثم العودة للتطبيق.',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
