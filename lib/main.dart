import 'package:flutter/material.dart';
import 'package:neo_admin/app/main_screen.dart';
import 'package:neo_admin/constant/theme.dart';
import 'package:neo_admin/features/dashboard/presentation/ui/dashboard_screen.dart';
import 'package:neo_admin/features/login/presentation/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Admin Neo',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme(context),
      home: const LoginScreen(),
      initialRoute: '/main',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/main': (context) => const MainScreen(name: 'Herlan'),
        '/dashboard': (context) => const DashboardScreen(),
      },
    );
  }
}
