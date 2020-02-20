import 'package:flutter/material.dart';
import 'pages/sign_in_page.dart';

void main() => runApp(App());

class App extends StatelessWidget {
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

