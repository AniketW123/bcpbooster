import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'page.dart';
import 'start_page.dart';
import '../constants.dart';
import '../util/alert.dart';
import '../util/text.dart';

// TODO make pages login required

class SignInPage extends StatefulWidget {
  static const String path = '/sign_in';

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends PageState<SignInPage> {
  void _getSheet() async {
    startLoading();

    http.Response res = await http.get(
      'https://sheets.googleapis.com/v4/spreadsheets/$sheetId',
      headers: await googleSignIn.currentUser.authHeaders,
    );

    stopLoading();

    if (res.statusCode == 200) {
      Navigator.pushNamed(context, StartPage.path);
    } else {
      String errorMessage = res.statusCode == 403
          ? 'Unfortunately, this account does not have access to the signups spreadsheet (Error 403). Please sign in with a different account or contact $accessEmail to get access.'
          : 'Error ${res.statusCode}. Try again.';

      alert(
        context: context,
        title: 'Error!',
        message: Text(errorMessage),
        actions: <Widget>[
          AlertButton(
            'OK',
            onPressed: () {
              googleSignIn.disconnect().then((_) => Navigator.pop(context));
            },
          ),
        ],
      );
    }
  }

  void _userChanged(GoogleSignInAccount account) {
    if (account?.id != null) {
      _getSheet();
    } else {
      googleSignIn.signOut();
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
  PreferredSizeWidget buildAppBar(BuildContext context) {
    return AppBar(
      title: Text('Sign In'),
    );
  }

  @override
  Widget buildBody(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          TitleText('Sign in to access form'),
          Padding(
            padding: const EdgeInsets.all(50.0),
            child: Transform.scale(
              scale: 1.25,
              child: GoogleSignInButton(
                onPressed: googleSignIn.signIn,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
