import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

final GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['https://www.googleapis.com/auth/spreadsheets']);

const String sheetId = '1QAzPiIC-C6yrLt_50GGB5czH60mFEXIZt9yPSJIKQao';
const String accessEmail = 'ashish.warty@gmail.com';

const Color primaryColor = Color(0xFF2C3872);
const Color backgroundColor = Color(0xFFABBAF2);

const TextStyle inputStyle = TextStyle(
  fontFamily: 'Avenir Next',
  fontSize: 18.0,
  color: Colors.black,
);
