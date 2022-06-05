import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'constants.dart';
import 'pages/home_page.dart';

void main() async {
  await Firebase.initializeApp();
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BCP Booster Club',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: primaryColor, // Hex: 2C3872
        scaffoldBackgroundColor: backgroundColor, // Hex: ABBAF2
        appBarTheme: AppBarTheme(
          backgroundColor: primaryColor,
        ),
        fontFamily: GoogleFonts.nunitoSans().fontFamily,
      ),
      home: HomePage(),
    );
  }
}

