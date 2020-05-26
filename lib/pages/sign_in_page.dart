import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'page.dart';
import 'start_page.dart';
import '../constants.dart';
import '../util/alert.dart';
import '../util/text.dart';

class SignInPage extends StatefulWidget {
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
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => StartPage(),
          settings: RouteSettings(name: '/start')
        ),
      );
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

  Text _bodyText(List<String> text) {
    return Text(
      text.join(' '),
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 18.0
      ),
    );
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
      actions: [icon],
    );
  }

  @override
  Widget buildBody(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 50.0),
          child: Center(
            child: Column(
              children: <Widget>[
                TitleText('BCP Booster Club'),
                _bodyText([
                  'A center for managing members for Bellarmine College Prep\'s Booster Club Program.',
                  'The Booster Club is a great way to get free tickets to sporting events and BCP merchandise.',
                  'Booster Club volunteers can use this website to add new members and search for/update the status of existing members'
                ]),
                Padding(
                  padding: EdgeInsets.only(top: 50.0, bottom: 20.0),
                  child: Text(
                    'Volunteer Login',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w600
                    ),
                  ),
                ),
                GoogleSignInButton(
                  onPressed: googleSignIn.signIn,
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 0.0,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 6.0),
            child: GestureDetector(
              child: Text(
                'Privacy Policy',
                style: TextStyle(
                  decoration: TextDecoration.underline
                ),
              ),
              onTap: () {
                launch('https://booster.belldcb.com/privacy');
              },
            ),
          ),
        )
      ],
    );
  }
}
