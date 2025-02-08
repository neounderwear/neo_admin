import 'package:flutter/material.dart';
import 'package:neo_admin/constant/theme.dart';
import 'package:neo_admin/features/login/presentation/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Admin Neo',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme(context),
      home: const LoginScreen(),
    );
  }
}
