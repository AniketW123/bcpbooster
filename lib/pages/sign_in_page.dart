import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'profile_info_page.dart';
import '../util/alert.dart';
import '../globals.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool _loading = false;

  void _getSheet() async {
    setState(() => _loading = true);

    http.Response res = await http.get(
      'https://sheets.googleapis.com/v4/spreadsheets/$sheetId',
      headers: await googleSignIn.currentUser.authHeaders,
    );

    setState(() => _loading = false);

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

  void _userChanged(GoogleSignInAccount account) {
    if (account != null) {
      _getSheet();
    } else {
      Navigator.popUntil(context, (route) => route.isFirst);
    }
  }

  @override
  void initState() {
    googleSignIn.onCurrentUserChanged.listen(_userChanged);
    googleSignIn.signInSilently();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
      ),
      body: ModalProgressHUD(
        inAsyncCall: _loading,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              'Bellarmine Booster Club Signups',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 72.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            Transform.scale(
              scale: 1.25,
              child: GoogleSignInButton(
                onPressed: () {
                  googleSignIn.signIn();
                },
              ),
            ),
            SizedBox()
          ],
        ),
      ),
    );
  }
}
