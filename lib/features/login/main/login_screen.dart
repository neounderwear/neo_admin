import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:neo_admin/features/login/ui/login_mobile.dart';
import 'package:neo_admin/features/login/ui/login_web.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth <= 600) {
          return LoginMobile(
            function: () {
              context.go('/main/dashboard');
            },
          );
        } else {
          return LoginWeb(
            function: () {
              context.go('/main/dashboard');
            },
          );
        }
      },
    );
  }
}
