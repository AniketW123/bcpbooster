import 'package:flutter/material.dart';
import 'constants.dart';
import 'pages/sign_in_page.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BCP Booster Club',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: primaryColor, // Hex: 2C3872
        scaffoldBackgroundColor: backgroundColor, // Hex: ABBAF2
        fontFamily: 'Avenir Next'
      ),
      home: SignInPage(),
    );
  }
}

