import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

final GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['https://www.googleapis.com/auth/spreadsheets']);

const String _mainSheet = '1TjRswZvICftay4ViDpC7Ig-r-ErCUZhXAEMR3gRiR2c';
const String _testSheet = '1QAzPiIC-C6yrLt_50GGB5czH60mFEXIZt9yPSJIKQao';

const String sheetId = kDebugMode ? _testSheet : _mainSheet;
const String accessEmail = 'ashish.warty@gmail.com';

const Color primaryColor = Color(0xFF2C3872);
const Color backgroundColor = Color(0xFFABBAF2);

final Widget icon = Image.network('/icons/android-icon-192x192.png', width: 40);

const TextStyle inputStyle = TextStyle(
  fontFamily: 'Avenir Next',
  fontSize: 18.0,
  color: Colors.black,
);
