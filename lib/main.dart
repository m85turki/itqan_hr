import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'pages/signup_page.dart';
import 'pages/verify_email_page.dart';
import 'pages/home_page.dart'; // هذه صفحة رئيسية مؤقتة

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url:
        'https://ynhygbdtpmgolrfmfqgv.supabase.co', // 🔁 ضع رابط مشروعك هنا من Supabase
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InluaHlnYmR0cG1nb2xyZm1mcWd2Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDYyNjQzNjUsImV4cCI6MjA2MTg0MDM2NX0.Ep3k4MTAYQZ7gRlggEfXNeItpJNAfcopVZSqEzu6mTM', // 🔁 ضع الـ anon key من Supabase
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Itqan HR',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/signup',
      routes: {
        '/signup': (context) => const SignupPage(),
        '/verify': (context) => const VerifyEmailPage(),
        '/home': (context) => const HomePage(),
      },
    );
  }
}
