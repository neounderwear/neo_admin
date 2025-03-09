import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:neo_admin/features/login/bloc/login_bloc.dart';
import 'package:neo_admin/features/login/bloc/login_state.dart';

// Layout untuk tampilan web
class LoginWeb extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final FocusNode emailFocusNode;
  final FocusNode passwordFocusNode;
  final Function function;

  const LoginWeb({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.emailFocusNode,
    required this.passwordFocusNode,
    required this.function,
  });

  @override
  State<LoginWeb> createState() => _LoginWebState();
}

class _LoginWebState extends State<LoginWeb> {
  bool obsecureText = true;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: KeyboardListener(
        focusNode: FocusNode(),
        onKeyEvent: (event) {
          if (event.logicalKey == LogicalKeyboardKey.enter) {
            FocusScope.of(context).unfocus();
          }
        },
        child: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccess) {
              context.go('/main/dashboard');
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Berhasil masuk',
                    style: TextStyle(color: Colors.white),
                  ),
                  duration: Duration(seconds: 2),
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.green,
                  width: 300.0,
                ),
              );
            } else if (state is LoginFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.message,
                    style: TextStyle(color: Colors.white),
                  ),
                  duration: Duration(seconds: 2),
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.red,
                  width: 300.0,
                ),
              );
            }
          },
          builder: (context, state) {
            return Scaffold(
              body: Center(
                child: Container(
                  height: size.height * 0.5,
                  width: size.height * 0.5,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24.0,
                      vertical: 18.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          child: Image.asset(
                            'assets/images/cv.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                        const Text(
                          'Halo!',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24.0,
                          ),
                        ),
                        const Text(
                          'Silakan masuk  untuk memulai petualangan hari ini',
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                        SizedBox(height: size.height * 0.04),
                        AutofillGroup(
                          child: Column(
                            children: [
                              SizedBox(
                                height: size.height * 0.05,
                                child: TextFormField(
                                  controller: widget.emailController,
                                  focusNode: widget.emailFocusNode,
                                  keyboardType: TextInputType.emailAddress,
                                  textInputAction: TextInputAction.next,
                                  autofillHints: const [AutofillHints.email],
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(8.0),
                                      ),
                                    ),
                                    prefixIcon: Icon(
                                      Icons.mail_outline_rounded,
                                      size: 20.0,
                                    ),
                                    labelText: 'Email',
                                  ),
                                ),
                              ),
                              SizedBox(height: size.height * 0.02),
                              SizedBox(
                                height: size.height * 0.05,
                                child: TextFormField(
                                  controller: widget.passwordController,
                                  focusNode: widget.passwordFocusNode,
                                  keyboardType: TextInputType.visiblePassword,
                                  textInputAction: TextInputAction.done,
                                  autofillHints: const [AutofillHints.password],
                                  decoration: InputDecoration(
                                    border: const OutlineInputBorder(
                                      borderSide: BorderSide(),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(8.0),
                                      ),
                                    ),
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          obsecureText = !obsecureText;
                                        });
                                      },
                                      icon: Icon(
                                        obsecureText
                                            ? Icons.lock_outline_rounded
                                            : Icons.lock_open_outlined,
                                        size: 20.0,
                                      ),
                                    ),
                                    labelText: 'Password',
                                    prefixIcon: const Icon(
                                      Icons.password_outlined,
                                      size: 20.0,
                                    ),
                                  ),
                                  obscureText: obsecureText,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: size.height * 0.03),
                        state is LoginLoading
                            ? SizedBox(
                                height: size.height * 0.05,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    minimumSize:
                                        const Size(double.infinity, 40.0),
                                  ),
                                  child: SpinKitThreeBounce(
                                    color: Colors.white,
                                    size: 20.0,
                                  ),
                                  onPressed: () {},
                                ),
                              )
                            : SizedBox(
                                height: size.height * 0.05,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    minimumSize:
                                        const Size(double.infinity, 40.0),
                                  ),
                                  child: const Text(
                                    'Masuk',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.0),
                                  ),
                                  onPressed: () {
                                    widget.function();
                                  },
                                ),
                              ),
                        SizedBox(height: size.height * 0.05),
                        const Text(
                          'Kendala login? Hubungi Master Admin',
                          style: TextStyle(
                            fontSize: 12.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
