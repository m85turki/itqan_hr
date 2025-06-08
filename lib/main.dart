import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'login_page.dart'; // تأكد أن اسم الملف صح

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
      debugShowCheckedModeBanner: false,
      title: 'Itqan HR',
      theme: ThemeData(primarySwatch: Colors.deepPurple, fontFamily: 'Arial'),
      home: const LoginPage(),
    );
  }
}
