import 'package:flutter/material.dart';
import 'login_page.dart'; // تأكد أنه نفس اسم الملف

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Itqan HR',
      theme: ThemeData(primarySwatch: Colors.deepPurple, fontFamily: 'Arial'),
      home: const LoginPage(),
    );
  }
}
