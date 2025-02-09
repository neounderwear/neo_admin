import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData theme(BuildContext context) {
    return ThemeData(
      fontFamily: 'Outfit',
      primaryColor: Colors.orange,
      scaffoldBackgroundColor: Colors.grey[200],
      appBarTheme: const AppBarTheme(
        color: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0.0,
      ),
      bottomAppBarTheme: const BottomAppBarTheme(
        color: Colors.white,
        shadowColor: Colors.grey,
      ),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(color: Color(0xFF116487), fontSize: 18.0),
        titleLarge: TextStyle(color: Colors.black, fontSize: 18.0),
      ),
      colorScheme: ColorScheme.fromSwatch()
          .copyWith(primary: Colors.orange, secondary: const Color(0xFF87D6EC)),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        contentPadding: const EdgeInsets.all(8.0),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(
            color: Colors.grey,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(
            width: 2.0,
            color: Colors.orangeAccent,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.0),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.error,
          ),
        ),
      ),
    );
  }
}
