import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final FocusNode emailFocusNode;
  late final FocusNode passwordFocusNode;
  bool obsecureText = true;
  final formKey = GlobalKey<FormState>();

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
        child: Scaffold(
          body: Center(
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(20.0)),
              child: Container(
                height: size.height * 0.5,
                width: size.height * 0.5,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24.0, vertical: 18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircleAvatar(
                        child: Placeholder(
                          fallbackHeight: 10.0,
                        ),
                      ),
                      SizedBox(height: size.height * 0.04),
                      const Text(
                        'Halo!',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
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
                                controller: emailController,
                                focusNode: emailFocusNode,
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
                                controller: passwordController,
                                focusNode: passwordFocusNode,
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
                      SizedBox(
                        height: size.height * 0.05,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(double.infinity, 40.0),
                          ),
                          child: const Text(
                            'Masuk',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16.0),
                          ),
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            context.go('/main');
                            // Navigator.of(context).pushReplacement(
                            //   MaterialPageRoute(
                            //     builder: (context) =>
                            //         MainScreen(name: emailController.text.trim()),
                            //   ),
                            // );
                          },
                        ),
                      ),
                      SizedBox(height: size.height * 0.05),
                      const Text(
                        'Kendala login? Hubungi Master Admin',
                        style: TextStyle(
                          fontSize: 10.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
