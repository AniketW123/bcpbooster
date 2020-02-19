import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['https://www.googleapis.com/auth/spreadsheets']
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Sign In'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              'Bellarmine Booster Club Signups',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 72.0,
                fontWeight: FontWeight.w600,
                fontFamily: 'Avenir Next',
              ),
            ),
            SignInButton(
              Buttons.Google,
              onPressed: () {
                print('sign in');
              },
            ),
          ],
        )
    );
  }
}
