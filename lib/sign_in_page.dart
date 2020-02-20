import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'profile_info_page.dart';
import 'alert.dart';
import 'globals.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  void _getSheet() async {
    http.Response res = await http.get('https://sheets.googleapis.com/v4/spreadsheets/$sheetId', headers: await googleSignIn.currentUser.authHeaders,);
    if (res.statusCode == 200) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ProfileInfoPage()),
      );
    } else {
      alert(
        context: context,
        title: 'Error!',
        message: 'Unfortunately, this account does not have access to the signups spreadsheet. Please sign in with a different account or contact $accessEmail to get access.',
        actions: <Widget>[
          AlertButton(
            'OK',
            onPressed: () {
              googleSignIn.disconnect().then((_) => Navigator.pop(context));
            },
          )
        ],
      );
    }
  }

  void _silentSignIn(GoogleSignInAccount account) {
    if (account != null) {
      _getSheet();
    }
  }

  @override
  void initState() {
    super.initState();
    googleSignIn.signInSilently().then(_silentSignIn);
  }

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
                googleSignIn.signIn().then((_) => _getSheet());
              },
            ),
          ],
        ),
    );
  }
}
