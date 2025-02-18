import 'package:flutter/material.dart';
import 'package:neo_admin/features/login/ui/login_mobile.dart';
import 'package:neo_admin/features/login/ui/login_web.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxHeight <= 600) {
          return LoginMobile();
        } else {
          return LoginWeb();
        }
      },
    );
  }
}
