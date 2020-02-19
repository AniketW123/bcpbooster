import 'package:flutter/material.dart';
import 'sign_in_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(0xFF2C3872), // Hex: 2C3872
        scaffoldBackgroundColor: Color(0xFFABBAF2), // Hex: ABBAF2
      ),
      home: SignInPage()
    );
  }
}

