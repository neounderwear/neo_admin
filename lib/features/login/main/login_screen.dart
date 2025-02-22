import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_admin/features/login/bloc/login_bloc.dart';
import 'package:neo_admin/features/login/bloc/login_event.dart';
import 'package:neo_admin/features/login/ui/login_mobile.dart';
import 'package:neo_admin/features/login/ui/login_web.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Layout Builder
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final FocusNode emailFocusNode;
  late final FocusNode passwordFocusNode;
  final supabase = Supabase.instance.client;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    emailFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth <= 600) {
          return LoginMobile(
            emailController: emailController,
            passwordController: passwordController,
            emailFocusNode: emailFocusNode,
            passwordFocusNode: passwordFocusNode,
            function: () {
              BlocProvider.of<LoginBloc>(context).add(
                LoginSubmitted(
                  email: emailController.text,
                  password: passwordController.text,
                ),
              );
            },
          );
        } else {
          return LoginWeb(
            emailController: emailController,
            passwordController: passwordController,
            emailFocusNode: emailFocusNode,
            passwordFocusNode: passwordFocusNode,
            function: () {
              BlocProvider.of<LoginBloc>(context).add(
                LoginSubmitted(
                  email: emailController.text,
                  password: passwordController.text,
                ),
              );
            },
          );
        }
      },
    );
  }
}
